import 'package:flutter/foundation.dart';
import 'package:roadmap_ai/core/common/token_storage/token_storage.dart';
import 'package:roadmap_ai/features/auth/domain/repository/auth_repository.dart';
import 'package:roadmap_ai/utils/failures.dart';
import 'package:roadmap_ai/utils/usecase.dart';
import 'package:fpdart/fpdart.dart';

class SignupUser implements Usecase<SignupUserParams, void> {
  final AuthRepository _repository;
  final TokenStorage _tokenStorage;

  SignupUser(this._repository, this._tokenStorage);

  @override
  TaskEither<Failure, void> call(SignupUserParams params) {
    final signupResult = _repository.signUp(
      email: params.email,
      password: params.password,
      username: params.username,
    );

    // if on web, no need to save tokens in secure storage
    if (kIsWeb) {
      return signupResult;
    }
    // otherwise store the tokens
    return signupResult.flatMap(
      (tokens) => _tokenStorage.saveTokens(
        accessToken: tokens.accessToken,
        refreshToken: tokens.refreshToken,
      ),
    );
  }
}

class SignupUserParams {
  final String email;
  final String password;
  final String username;

  SignupUserParams({
    required this.email,
    required this.password,
    required this.username,
  });
}
