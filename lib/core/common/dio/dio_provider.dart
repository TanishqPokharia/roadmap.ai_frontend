import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/browser.dart';
import 'package:roadmap_ai/core/common/interceptors/token_attach_interceptor.dart';
import 'package:roadmap_ai/core/common/interceptors/refresh_token_interceptor.dart';

part 'dio_provider.g.dart';

@riverpod
Dio dio(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: dotenv.env['BASE_URL']!,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      validateStatus: (status) => true, // handle errors in app
      contentType: 'application/json',
    ),
  );

  // send cookies with every request for web
  if (kIsWeb) {
    final browserAdapter = BrowserHttpClientAdapter()..withCredentials = true;
    dio.httpClientAdapter = browserAdapter;
    dio.options.headers['withCredentials'] = true;
  }

  // attach tokens with request for mobile
  if (!kIsWeb) {
    final tokenAttachInterceptor = ref.read(tokenAttachInterceptorProvider);
    dio.interceptors.add(tokenAttachInterceptor);
  }

  // Add refresh token interceptor for both web and mobile
  final refreshTokenInterceptor = ref.read(refreshTokenInterceptorProvider);
  dio.interceptors.add(refreshTokenInterceptor);

  // ✅ Add logger interceptor (only for debug mode)
  if (kDebugMode) {
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseHeader: false,
        responseBody: true,
        error: true,
      ),
    );
  }

  return dio;
}
