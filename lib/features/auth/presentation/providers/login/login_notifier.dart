import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/features/auth/domain/usecases/login_user/login_user.dart';

part 'login_notifier.g.dart';

enum LoginState { initial, success }

@riverpod
class LoginNotifier extends _$LoginNotifier {
  @override
  FutureOr<LoginState> build() async {
    return LoginState.initial;
  }

  void login(String email, String password) async {
    state = AsyncLoading();
    final login = await ref
        .read(loginUserProvider)
        .call(LoginUserParams(email: email, password: password))
        .run();
    login.fold(
      (failure) {
        state = AsyncError(failure, StackTrace.current);
      },
      (r) {
        state = const AsyncData(LoginState.success);
      },
    );
  }
}
