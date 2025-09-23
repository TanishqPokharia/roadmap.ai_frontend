import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/features/auth/domain/usecases/signup_user/signup_user.dart';

part 'signup_notifier.g.dart';

enum SignUpState { initial, error, success }

@riverpod
class SignupNotifier extends _$SignupNotifier {
  @override
  FutureOr<SignUpState> build() {
    return SignUpState.initial;
  }

  void signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    state = AsyncLoading();
    final signUp = await ref
        .read(signUpUserProvider)
        .call(
          SignupUserParams(
            username: username,
            email: email,
            password: password,
          ),
        )
        .run();
    signUp.fold(
      (failure) {
        state = AsyncError(failure, StackTrace.current);
      },
      (success) {
        // No need to reset providers on signup - it's a new user
        // Providers will naturally load fresh data when accessed
        state = AsyncData(SignUpState.success);
      },
    );
  }
}
