import 'package:dio/dio.dart';
import 'package:dio/browser.dart';

/// Configures Dio adapter for web platform with credentials support
void configureDioAdapter(Dio dio) {
  final browserAdapter = BrowserHttpClientAdapter()..withCredentials = true;
  dio.httpClientAdapter = browserAdapter;
  dio.options.headers['withCredentials'] = true;
}
