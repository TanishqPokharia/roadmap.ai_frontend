import 'package:fpdart/fpdart.dart';
import 'package:roadmap_ai/features/auth/data/models/tokens/tokens.dart';
import 'package:roadmap_ai/utils/failures.dart';

abstract class AuthDatasource {
  TaskEither<Failure, TokensModel> login({
    required String email,
    required String password,
  });
  TaskEither<Failure, TokensModel> signUp({
    required String email,
    required String password,
    required String username,
  });
}
