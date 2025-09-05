import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:roadmap_ai/core/common/token_storage/flutter_secure_storage_token_storage_impl.dart';
import 'package:roadmap_ai/core/common/token_storage/token_storage.dart';
import 'package:roadmap_ai/features/auth/data/datasource/impl/auth_datasource_impl.dart';
import 'package:roadmap_ai/features/auth/data/datasource/interface/auth_datasource.dart';
import 'package:roadmap_ai/features/auth/data/repository/auth_repository_impl.dart';
import 'package:roadmap_ai/features/auth/domain/repository/auth_repository.dart';
import 'package:roadmap_ai/features/auth/domain/usecases/is_user_logged_in.dart';
import 'package:roadmap_ai/features/auth/domain/usecases/login_user/login_user.dart';
import 'package:roadmap_ai/features/auth/domain/usecases/signup_user.dart';

void registerDependencies(GetIt sl) {
  // Token Storage
  sl.registerLazySingleton<TokenStorage>(
    () => FlutterSecureStorageTokenStorageImpl(FlutterSecureStorage()),
  );

  // Register Dio
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://localhost:3000/api/v1',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
    ),
  );

  sl.registerLazySingleton<Dio>(() => dio);

  // Datasources
  sl.registerLazySingleton<AuthDatasource>(
    () => AuthDatasourceImpl(sl(), sl()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  // Usecases
  sl.registerLazySingleton<LoginUser>(() => LoginUser(sl(), sl()));
  sl.registerLazySingleton<SignupUser>(() => SignupUser(sl(), sl()));
  sl.registerLazySingleton<IsUserLoggedIn>(() => IsUserLoggedIn(sl()));
}
