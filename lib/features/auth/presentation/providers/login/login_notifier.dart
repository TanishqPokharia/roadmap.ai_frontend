import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_notifier.g.dart';

@riverpod
class LoginNotifier extends _$LoginNotifier {
  @override
  FutureOr<LoginState> build() async {
    return LoginState.initial;
  }

  void login(String email, String password) async {
    state = AsyncLoading();
    await Future.delayed(Duration(seconds: 2));
    state = AsyncData(LoginState.success);
  }
}

enum LoginState { initial, loading, success, error }
