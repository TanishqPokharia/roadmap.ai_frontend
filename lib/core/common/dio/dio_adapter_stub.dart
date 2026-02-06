import 'package:dio/dio.dart';
import 'package:dio/io.dart';

/// Configures Dio adapter for mobile and desktop platforms
void configureDioAdapter(Dio dio) {
  dio.httpClientAdapter = IOHttpClientAdapter();
}
