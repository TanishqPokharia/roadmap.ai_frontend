import 'package:fpdart/fpdart.dart';
import 'package:roadmap_ai/features/auth/domain/entities/tokens.dart';
import 'package:roadmap_ai/utils/failures.dart';

abstract class AuthRepository {
  TaskEither<Failure, Tokens> login({
    required String email,
    required String password,
  });
  TaskEither<Failure, Tokens> signUp({
    required String email,
    required String password,
    required String username,
  });
}
