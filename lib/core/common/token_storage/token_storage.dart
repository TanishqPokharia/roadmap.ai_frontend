import 'package:fpdart/fpdart.dart';
import 'package:roadmap_ai/features/auth/domain/entities/tokens.dart';
import 'package:roadmap_ai/utils/failures.dart';

abstract class TokenStorage {
  TaskEither<Failure, void> saveTokens({
    required String accessToken,
    required String refreshToken,
  });
  TaskEither<Failure, Tokens?> getTokens();
  TaskEither<Failure, void> deleteTokens();
}
