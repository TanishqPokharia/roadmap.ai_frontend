import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:roadmap_ai/core/utils/failures.dart';
import 'package:roadmap_ai/core/utils/http_error_handler.dart';

/// A utility function to handle all data source errors and return a [Failure] object.
Failure dataSourceErrorHandler({required Object error, String? message}) {
  if (message != null) {
    log(message, error: error, stackTrace: StackTrace.current);
  }
  if (error is DioException) {
    if (error.type == DioExceptionType.connectionTimeout) {
      return TimeoutFailure('Connection Timeout, please try again later');
    }
    if (error.response != null) {
      return httpErrorHandler(error.response!.statusCode ?? 0);
    }
  }

  // For any other unknown errors
  if (error is Failure) return error;
  return UnknownFailure(error.toString());
}
