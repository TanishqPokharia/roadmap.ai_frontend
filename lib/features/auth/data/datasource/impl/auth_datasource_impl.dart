import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:roadmap_ai/features/auth/data/datasource/interface/auth_datasource.dart';
import 'package:roadmap_ai/features/auth/data/models/tokens/tokens.dart';
import 'package:roadmap_ai/utils/failures.dart';
import 'package:roadmap_ai/utils/http_error_handler.dart';

class AuthDatasourceImpl implements AuthDatasource {
  final Dio _dio;
  AuthDatasourceImpl(this._dio);

  @override
  TaskEither<Failure, TokensModel> login({
    required String email,
    required String password,
  }) {
    return TaskEither.tryCatch(
      () async {
        final response = await _dio.post(
          '/auth/login',
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
        if (error is Failure) return error;
        if (error is DioException) {
          if (error.response != null) {
            return httpErrorHandler(error.response!.statusCode ?? 0);
          } else {
            return UnknownFailure(error.response.toString());
          }
        }

        return UnknownFailure(error.toString());
      },
    );
  }

  @override
  TaskEither<Failure, TokensModel> signUp({
    required String email,
    required String password,
    required String username,
  }) {
    return TaskEither.tryCatch(
      () async {
        final response = await _dio.post(
          '/auth/signup',
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
        if (error is Failure) return error;
        if (error is DioException) {
          if (error.response != null) {
            return httpErrorHandler(error.response!.statusCode ?? 0);
          } else {
            return UnknownFailure(error.response.toString());
          }
        }

        return UnknownFailure(error.toString());
      },
    );
  }
}
