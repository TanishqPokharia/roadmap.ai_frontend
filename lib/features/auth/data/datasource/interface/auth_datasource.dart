import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:roadmap_ai/features/auth/data/models/tokens/tokens.dart';
import 'package:roadmap_ai/core/utils/failures.dart';
import 'package:roadmap_ai/features/auth/data/models/user_details/user_details.dart';

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
  TaskEither<Failure, UserDetailsModel> getUserDetails();
  TaskEither<Failure, String> updateAvatar(MultipartFile image);
}
