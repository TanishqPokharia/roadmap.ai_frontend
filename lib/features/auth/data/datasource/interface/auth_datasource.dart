import 'package:fpdart/fpdart.dart';
import 'package:roadmap_ai/features/auth/data/models/tokens/tokens.dart';
import 'package:roadmap_ai/core/utils/failures.dart';

abstract class AuthDatasource {
  TaskEither<Failure, TokensModel> loginMobile({
    required String email,
    required String password,
  });
  TaskEither<Failure, TokensModel> signUpMobile({
    required String email,
    required String password,
    required String username,
  });
  TaskEither<Failure, void> loginWeb({
    required String email,
    required String password,
  });
  TaskEither<Failure, void> signUpWeb({
    required String email,
    required String password,
    required String username,
  });
  TaskEither<Failure, bool> isLoggedInMobile();
  TaskEither<Failure, bool> isLoggedInWeb();
  TaskEither<Failure, void> logoutMobile();
  TaskEither<Failure, void> logoutWeb();
}
