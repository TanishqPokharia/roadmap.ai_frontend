import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:roadmap_ai/core/common/token_storage/token_storage.dart';
import 'package:roadmap_ai/features/auth/domain/entities/tokens.dart';
import 'package:roadmap_ai/utils/failures.dart';

class FlutterSecureStorageTokenStorageImpl implements TokenStorage {
  final FlutterSecureStorage _storage;

  FlutterSecureStorageTokenStorageImpl(this._storage);
  @override
  TaskEither<Failure, void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) {
    return TaskEither.tryCatch(
      () async {
        await _storage.write(key: 'access_token', value: accessToken);
        await _storage.write(key: 'refresh_token', value: refreshToken);
      },
      (error, stackTrace) {
        return TokenStorageFailure("Failed to save tokens: $error $stackTrace");
      },
    );
  }

  @override
  TaskEither<Failure, Tokens> getTokens() {
    return TaskEither.tryCatch(
      () async {
        final accessToken = await _storage.read(key: 'access_token');
        final refreshToken = await _storage.read(key: 'refresh_token');
        if (accessToken == null || refreshToken == null) {
          throw TokenStorageFailure("Tokens not found in storage");
        }
        return Tokens(accessToken: accessToken, refreshToken: refreshToken);
      },
      (error, stackTrace) {
        // if the error is already a TokenStorageFailure due to tokens not found, return it directly
        if (error is TokenStorageFailure) return error;
        return TokenStorageFailure("Failed to get tokens: $error $stackTrace");
      },
    );
  }
}
