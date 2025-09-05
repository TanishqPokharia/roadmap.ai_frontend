import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/common/providers/dio_provider.dart';
import 'package:roadmap_ai/core/common/token_storage/flutter_secure_storage_token_storage_impl.dart';
import 'package:roadmap_ai/core/common/token_storage/token_storage.dart';
import 'package:roadmap_ai/features/auth/data/datasource/interface/auth_datasource.dart';
import 'package:roadmap_ai/features/auth/data/models/tokens/tokens.dart';
import 'package:roadmap_ai/core/utils/failures.dart';
import 'package:roadmap_ai/core/utils/http_error_handler.dart';

part 'auth_datasource_impl.g.dart';

@riverpod
AuthDatasource authDatasource(Ref ref) {
  return AuthDatasourceImpl(
    ref.read(dioProvider),
    ref.read(flutterSecureStorageProvider),
  );
}

class AuthDatasourceImpl implements AuthDatasource {
  final Dio _dio;
  final TokenStorage _tokenStorage;
  AuthDatasourceImpl(this._dio, this._tokenStorage);

  @override
  TaskEither<Failure, TokensModel> loginMobile({
    required String email,
    required String password,
  }) {
    return TaskEither.tryCatch(
      () async {
        final response = await _dio.post(
          '/user/login',
          data: {'email': email, 'password': password},
        );

        if (response.statusCode != 200) {
          throw httpErrorHandler(response.statusCode ?? 0);
        }

        final data = response.data;
        return TokensModel.fromJson(data);
      },
      (error, stackTrace) {
        log('Login failed', error: error, stackTrace: stackTrace);
        if (error is DioException) {
          if (error.response != null) {
            return httpErrorHandler(error.response!.statusCode ?? 0);
          } else {
            return UnknownFailure(error.response.toString());
          }
        }

        if (error is Failure) return error;

        return UnknownFailure(error.toString());
      },
    );
  }

  @override
  TaskEither<Failure, TokensModel> signUpMobile({
    required String email,
    required String password,
    required String username,
  }) {
    return TaskEither.tryCatch(
      () async {
        final response = await _dio.post(
          '/user/signup',
          data: {'email': email, 'password': password, 'username': username},
        );

        if (response.statusCode != 201) {
          throw httpErrorHandler(response.statusCode ?? 0);
        }
        final data = response.data;
        return TokensModel.fromJson(data);
      },
      (error, stackTrace) {
        log('SignUp failed', error: error, stackTrace: stackTrace);
        if (error is DioException) {
          if (error.response != null) {
            return httpErrorHandler(error.response!.statusCode ?? 0);
          } else {
            return UnknownFailure(error.response.toString());
          }
        }

        if (error is Failure) return error;

        return UnknownFailure(error.toString());
      },
    );
  }

  @override
  TaskEither<Failure, bool> isLoggedInMobile() {
    return _tokenStorage.getTokens().map((tokens) => tokens != null);
  }

  @override
  TaskEither<Failure, bool> isLoggedInWeb() {
    return TaskEither.tryCatch(
      () async {
        final response = await _dio.get('/user/validate');
        if (response.statusCode == 200) {
          return true;
        } else if (response.statusCode == 401) {
          return false;
        } else {
          throw httpErrorHandler(response.statusCode ?? 0);
        }
      },
      (error, stackTrace) {
        log('isLoggedInWeb check failed', error: error, stackTrace: stackTrace);
        if (error is DioException) {
          if (error.response != null) {
            return httpErrorHandler(error.response!.statusCode ?? 0);
          } else {
            return UnknownFailure(error.response.toString());
          }
        }

        if (error is Failure) return error;

        return UnknownFailure(error.toString());
      },
    );
  }

  @override
  TaskEither<Failure, void> loginWeb({
    required String email,
    required String password,
  }) {
    // same as loginMobile but without returning tokens
    return TaskEither.tryCatch(
      () async {
        final response = await _dio.post(
          '/user/login',
          data: {'email': email, 'password': password},
        );

        if (response.statusCode != 200) {
          throw httpErrorHandler(response.statusCode ?? 0);
        }

        return;
      },
      (error, stackTrace) {
        log('LoginWeb failed', error: error, stackTrace: stackTrace);
        if (error is BadRequestFailure) {
          return BadRequestFailure('Invalid email or password');
        }

        if (error is DioException) {
          if (error.response?.statusCode == 400) {
            return BadRequestFailure('Invalid email or password');
          }
          if (error.response != null) {
            return httpErrorHandler(error.response!.statusCode ?? 0);
          } else {
            return UnknownFailure(error.response.toString());
          }
        }

        if (error is Failure) return error;

        return UnknownFailure(error.toString());
      },
    );
  }

  @override
  TaskEither<Failure, void> signUpWeb({
    required String email,
    required String password,
    required String username,
  }) {
    // same as signUpMobile but without returning tokens
    return TaskEither.tryCatch(
      () async {
        final response = await _dio.post(
          '/user/signup',
          data: {'email': email, 'password': password, 'username': username},
        );

        if (response.statusCode != 201) {
          throw httpErrorHandler(response.statusCode ?? 0);
        }

        return;
      },
      (error, stackTrace) {
        log('SignUpWeb failed', error: error, stackTrace: stackTrace);
        if (error is DioException) {
          if (error.response != null) {
            return httpErrorHandler(error.response!.statusCode ?? 0);
          } else {
            return UnknownFailure(error.response.toString());
          }
        }
        if (error is Failure) return error;

        return UnknownFailure(error.toString());
      },
    );
  }

  @override
  TaskEither<Failure, void> logoutMobile() {
    return _tokenStorage.deleteTokens();
  }

  @override
  TaskEither<Failure, void> logoutWeb() {
    return TaskEither.tryCatch(
      () async {
        final response = await _dio.get('/user/logout');
        if (response.statusCode == 200) {
          return;
        } else {
          throw httpErrorHandler(response.statusCode ?? 0);
        }
      },
      (error, stackTrace) {
        log('LogoutWeb failed', error: error, stackTrace: stackTrace);
        if (error is DioException) {
          if (error.response != null) {
            return httpErrorHandler(error.response!.statusCode ?? 0);
          } else {
            return UnknownFailure(error.response.toString());
          }
        }
        if (error is Failure) return error;

        return UnknownFailure(error.toString());
      },
    );
  }
}
