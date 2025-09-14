import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:roadmap_ai/features/auth/domain/entities/tokens.dart';
import 'package:roadmap_ai/core/utils/failures.dart';
import 'package:roadmap_ai/features/auth/domain/entities/user_details.dart';

abstract class AuthRepository {
  TaskEither<Failure, Tokens> loginMobile({
    required String email,
    required String password,
  });
  TaskEither<Failure, Tokens> signUpMobile({
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
  TaskEither<Failure, UserDetails> getUserDetails();
  TaskEither<Failure, String> updateAvatar(MultipartFile image);
}
