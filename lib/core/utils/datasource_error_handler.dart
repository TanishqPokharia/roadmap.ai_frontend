import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:roadmap_ai/core/utils/failures.dart';
import 'package:roadmap_ai/core/utils/http_error_handler.dart';

Failure dataSourceErrorHandler({required Object error, String? message}) {
  if (message != null) {
    if (kDebugMode) log(message, error: error, stackTrace: StackTrace.current);
  }
  if (error is DioException) {
    if (error.type == DioExceptionType.connectionTimeout) {
      return TimeoutFailure('Connection Timeout, please try again later');
    }

    if (error.type == DioExceptionType.connectionError) {
      return ConnectionFailure("Failed to connect to server");
    }
    if (error.response != null) {
      return httpErrorHandler(error.response!.statusCode ?? 0);
    }
  }

  // For any other unknown errors
  if (error is Failure) return error;
  return UnknownFailure(error.toString());
}
