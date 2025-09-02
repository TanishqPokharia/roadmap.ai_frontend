import 'package:fpdart/fpdart.dart';
import 'package:roadmap_ai/features/auth/data/datasource/interface/auth_datasource.dart';
import 'package:roadmap_ai/features/auth/domain/entities/tokens.dart';
import 'package:roadmap_ai/features/auth/domain/repository/auth_repository.dart';
import 'package:roadmap_ai/utils/failures.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource _datasource;

  AuthRepositoryImpl(this._datasource);
  @override
  TaskEither<Failure, Tokens> login({
    required String email,
    required String password,
  }) {
    final result = _datasource.login(email: email, password: password);
    return result.map(
      (tokensModel) => Tokens(
        accessToken: tokensModel.accessToken,
        refreshToken: tokensModel.refreshToken,
      ),
    );
  }

  @override
  TaskEither<Failure, Tokens> signUp({
    required String email,
    required String password,
    required String username,
  }) {
    final result = _datasource.signUp(
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
}
