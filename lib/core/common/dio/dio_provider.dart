import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/common/interceptors/token_attach_interceptor.dart';
import 'package:roadmap_ai/core/common/interceptors/refresh_token_interceptor.dart';
import 'package:roadmap_ai/core/constants/api_config.dart';
import 'dio_adapter_stub.dart' if (dart.library.html) 'dio_adapter_web.dart';

part 'dio_provider.g.dart';

@riverpod
Dio dio(Ref ref) {
  final requestHeaders = <String, dynamic>{
    'credentials': 'include',
    if (!kIsWeb) 'X-Client-OS': Platform.operatingSystem,
  };

  final dio = Dio(
    BaseOptions(
      headers: requestHeaders,
      baseUrl: '${ApiConfig.baseUrl}/api/v1',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      // do not throw for any error the app will handle it
      validateStatus: (status) => true,
      contentType: 'application/json',
    ),
  );

  // Configure platform-specific adapter
  configureDioAdapter(dio);

  // attach tokens with request for mobile
  if (!kIsWeb) {
    final tokenAttachInterceptor = ref.read(tokenAttachInterceptorProvider);
    dio.interceptors.add(tokenAttachInterceptor);
  }

  // Add refresh token interceptor for both web and mobile
  final refreshTokenInterceptor = ref.read(refreshTokenInterceptorProvider);
  dio.interceptors.add(refreshTokenInterceptor);

  // logger for http requests
  if (kDebugMode) {
    dio.interceptors.add(
      PrettyDioLogger(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        compact: true,
        maxWidth: 100,
        error: true,
        enabled: kDebugMode,
      ),
    );
  }
  return dio;
}
