import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/browser.dart';

part 'dio_provider.g.dart';

@riverpod
Dio dio(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: dotenv.env['BASE_URL']!,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      // do not throw for any error the app will handle it
      validateStatus: (status) => true,
      contentType: 'application/json',
    ),
  );

  // send cookies with every request
  if (kIsWeb) {
    final browserAdapter = BrowserHttpClientAdapter()..withCredentials = true;
    dio.httpClientAdapter = browserAdapter;
  }
  dio.options.headers['withCredentials'] = true;

  return dio;
}
