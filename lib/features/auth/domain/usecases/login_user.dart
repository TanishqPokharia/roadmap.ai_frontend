import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:roadmap_ai/core/common/token_storage/token_storage.dart';
import 'package:roadmap_ai/features/auth/domain/repository/auth_repository.dart';
import 'package:roadmap_ai/utils/failures.dart';
import 'package:roadmap_ai/utils/usecase.dart';

class LoginUser implements Usecase<LoginUserParams, void> {
  final AuthRepository _repository;
  final TokenStorage _tokenStorage;

  LoginUser(this._repository, this._tokenStorage);

  @override
  TaskEither<Failure, void> call(LoginUserParams params) {
    final loginResult = _repository.login(
      email: params.email,
      password: params.password,
    );

    // if on web, no need to save tokens in secure storage
    if (kIsWeb) {
      return loginResult;
    }

    // otherwise store the tokens
    return loginResult.flatMap(
      (tokens) => _tokenStorage.saveTokens(
        accessToken: tokens.accessToken,
        refreshToken: tokens.refreshToken,
      ),
    );
  }
}

class LoginUserParams {
  final String email;
  final String password;

  LoginUserParams({required this.email, required this.password});
}
