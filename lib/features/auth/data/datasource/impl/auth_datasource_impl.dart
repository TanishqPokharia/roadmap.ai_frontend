import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/common/dio/dio_provider.dart';
import 'package:roadmap_ai/core/common/token_storage/flutter_secure_storage_token_storage_impl.dart';
import 'package:roadmap_ai/core/common/token_storage/token_storage.dart';
import 'package:roadmap_ai/core/utils/datasource_error_handler.dart';
import 'package:roadmap_ai/features/auth/data/datasource/interface/auth_datasource.dart';
import 'package:roadmap_ai/features/auth/data/models/tokens/tokens.dart';
import 'package:roadmap_ai/core/utils/failures.dart';
import 'package:roadmap_ai/core/utils/http_error_handler.dart';
import 'package:roadmap_ai/features/auth/data/models/user_details/user_details.dart';

part 'auth_datasource_impl.g.dart';

@riverpod
AuthDatasource authDatasource(Ref ref) {
  return AuthDatasourceImpl(
    ref.read(dioProvider),
    ref.read(tokenStorageProvider),
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
          '/auth/login',
          data: {'email': email, 'password': password},
        );

        if (response.statusCode == 400) {
          throw BadRequestFailure('Invalid email or password');
        } else if (response.statusCode == 404) {
          throw NotFoundFailure('User not found');
        } else if (response.statusCode != 200) {
          throw httpErrorHandler(response.statusCode ?? 0);
        }

        final data = response.data;
        return TokensModel.fromJson(data);
      },
      (error, stackTrace) => dataSourceErrorHandler(
        error: error,
        message: 'Login on mobile failed',
      ),
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
          '/auth/signup',
          data: {'email': email, 'password': password, 'username': username},
        );

        if (response.statusCode != 201) {
          throw httpErrorHandler(response.statusCode ?? 0);
        }
        final data = response.data;
        return TokensModel.fromJson(data);
      },
      (error, stackTrace) => dataSourceErrorHandler(
        error: error,
        message: 'SignUp on mobile failed',
      ),
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
        final response = await _dio.get('/auth/validate');
        if (response.statusCode == 200) {
          return true;
        } else if (response.statusCode == 401) {
          return false;
        } else {
          throw httpErrorHandler(response.statusCode ?? 0);
        }
      },
      (error, stackTrace) => dataSourceErrorHandler(
        error: error,
        message: 'Web Logged In check failed',
      ),
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
          '/auth/login',
          data: {'email': email, 'password': password},
        );

        if (response.statusCode == 400) {
          throw BadRequestFailure('Invalid email or password');
        } else if (response.statusCode == 404) {
          throw NotFoundFailure('User not found');
        } else if (response.statusCode != 200) {
          throw httpErrorHandler(response.statusCode ?? 0);
        }
        return;
      },
      (error, stackTrace) =>
          dataSourceErrorHandler(error: error, message: 'LoginWeb failed'),
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
          '/auth/signup',
          data: {'email': email, 'password': password, 'username': username},
        );

        if (response.statusCode != 201) {
          throw httpErrorHandler(response.statusCode ?? 0);
        }

        return;
      },
      (error, stackTrace) =>
          dataSourceErrorHandler(error: error, message: 'SignUpWeb failed'),
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
        final response = await _dio.get('/auth/logout');
        if (response.statusCode == 200) {
          return;
        } else {
          throw httpErrorHandler(response.statusCode ?? 0);
        }
      },
      (error, stackTrace) =>
          dataSourceErrorHandler(error: error, message: 'LogoutWeb failed'),
    );
  }

  @override
  TaskEither<Failure, UserDetailsModel> getUserDetails() {
    return TaskEither.tryCatch(
      () async {
        final response = await _dio.get('/auth/details');
        if (response.statusCode == 200) {
          final data = response.data;
          return UserDetailsModel.fromJson(data);
        } else {
          throw httpErrorHandler(response.statusCode ?? 0);
        }
      },
      (error, stackTrace) => dataSourceErrorHandler(
        error: error,
        message: 'Could not get user details',
      ),
    );
  }

  @override
  TaskEither<Failure, String> updateAvatar(MultipartFile image) {
    return TaskEither.tryCatch(
      () async {
        final formData = FormData.fromMap({'avatar': image});
        final response = await _dio.patch(
          '/auth/avatar/update',
          data: formData,
          options: Options(headers: {'Content-Type': 'multipart/form-data'}),
        );

        if (response.statusCode == 200) {
          final data = response.data;
          return data['avatar'] as String;
        }

        if (response.statusCode == 500) {
          throw ServerFailure(response.data['error']);
        }

        throw httpErrorHandler(response.statusCode ?? 0);
      },
      (error, stackTrace) => dataSourceErrorHandler(
        error: error,
        message: 'Could not update avatar',
      ),
    );
  }
}
