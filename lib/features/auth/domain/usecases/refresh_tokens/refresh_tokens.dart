// DEPRECATED: This use case is no longer needed as refresh token logic
// has been moved directly to RefreshTokenInterceptor to avoid circular dependencies
// All refresh token functionality is now handled automatically by the HTTP interceptor

/*
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/common/token_storage/flutter_secure_storage_token_storage_impl.dart';
import 'package:roadmap_ai/core/common/token_storage/token_storage.dart';
import 'package:roadmap_ai/core/utils/failures.dart';
import 'package:roadmap_ai/core/utils/no_params.dart';
import 'package:roadmap_ai/core/utils/usecase.dart';
import 'package:roadmap_ai/features/auth/data/repository/auth_repository_impl.dart';
import 'package:roadmap_ai/features/auth/domain/repository/auth_repository.dart';

part 'refresh_tokens.g.dart';

@riverpod
RefreshTokens refreshTokens(Ref ref) {
  return RefreshTokens(
    ref.read(authRepositoryProvider),
    ref.read(tokenStorageProvider),
  );
}

class RefreshTokens implements Usecase<NoParams, void> {
  final AuthRepository _repository;
  final TokenStorage _tokenStorage;

  RefreshTokens(this._repository, this._tokenStorage);

  @override
  TaskEither<Failure, void> call(NoParams params) {
    if (kIsWeb) {
      return _repository.refreshTokensWeb();
    } else {
      return _repository.refreshTokensMobile().flatMap(
        (tokens) => _tokenStorage.saveTokens(
          accessToken: tokens.accessToken,
          refreshToken: tokens.refreshToken,
        ),
      );
    }
  }
}
*/
