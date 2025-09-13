import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/features/auth/data/datasource/impl/auth_datasource_impl.dart';
import 'package:roadmap_ai/features/auth/data/datasource/interface/auth_datasource.dart';
import 'package:roadmap_ai/features/auth/domain/entities/tokens.dart';
import 'package:roadmap_ai/features/auth/domain/repository/auth_repository.dart';
import 'package:roadmap_ai/core/utils/failures.dart';
part 'auth_repository_impl.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  final datasource = ref.watch(authDatasourceProvider);
  return AuthRepositoryImpl(datasource);
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource _datasource;

  AuthRepositoryImpl(this._datasource);
  @override
  TaskEither<Failure, Tokens> loginMobile({
    required String email,
    required String password,
  }) {
    final result = _datasource.loginMobile(email: email, password: password);
    return result.map(
      (tokensModel) => Tokens(
        accessToken: tokensModel.accessToken,
        refreshToken: tokensModel.refreshToken,
      ),
    );
  }

  @override
  TaskEither<Failure, Tokens> signUpMobile({
    required String email,
    required String password,
    required String username,
  }) {
    final result = _datasource.signUpMobile(
      email: email,
      password: password,
      username: username,
    );
    return result.map(
      (tokensModel) => Tokens(
        accessToken: tokensModel.accessToken,
        refreshToken: tokensModel.refreshToken,
      ),
    );
  }

  @override
  TaskEither<Failure, bool> isLoggedInMobile() {
    return _datasource.isLoggedInMobile();
  }

  @override
  TaskEither<Failure, bool> isLoggedInWeb() {
    return _datasource.isLoggedInWeb();
  }

  @override
  TaskEither<Failure, void> loginWeb({
    required String email,
    required String password,
  }) {
    return _datasource.loginWeb(email: email, password: password);
  }

  @override
  TaskEither<Failure, void> signUpWeb({
    required String email,
    required String password,
    required String username,
  }) {
    return _datasource.signUpWeb(
      email: email,
      password: password,
      username: username,
    );
  }

  @override
  TaskEither<Failure, void> logoutMobile() {
    return _datasource.logoutMobile();
  }

  @override
  TaskEither<Failure, void> logoutWeb() {
    return _datasource.logoutWeb();
  }

  // Refresh token methods removed - handled by RefreshTokenInterceptor
}
