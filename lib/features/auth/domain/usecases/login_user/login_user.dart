import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/common/token_storage/flutter_secure_storage_token_storage_impl.dart';
import 'package:roadmap_ai/core/common/token_storage/token_storage.dart';
import 'package:roadmap_ai/features/auth/data/repository/auth_repository_impl.dart';
import 'package:roadmap_ai/features/auth/domain/repository/auth_repository.dart';
import 'package:roadmap_ai/core/utils/failures.dart';
import 'package:roadmap_ai/core/utils/usecase.dart';

part 'login_user.g.dart';

@riverpod
LoginUser loginUser(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  final tokenStorage = ref.watch(flutterSecureStorageProvider);
  return LoginUser(repository, tokenStorage);
}

class LoginUser implements Usecase<LoginUserParams, void> {
  final AuthRepository _repository;
  final TokenStorage _tokenStorage;

  LoginUser(this._repository, this._tokenStorage);

  @override
  TaskEither<Failure, void> call(LoginUserParams params) {
    // if on web, no need to save tokens in secure storage
    if (kIsWeb) {
      final loginResult = _repository.loginWeb(
        email: params.email,
        password: params.password,
      );
      return loginResult;
    }
    final loginResult = _repository.loginMobile(
      email: params.email,
      password: params.password,
    );

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
