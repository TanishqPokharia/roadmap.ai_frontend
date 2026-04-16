import 'dart:io';
import 'package:flutter/foundation.dart';

class AppConstants {
  const AppConstants._();
  static const googleClientId =
      "333824267929-h1dbc3krruskvb346djvh2t80onktmf7.apps.googleusercontent.com";
  static final isAndroid = !kIsWeb && Platform.isAndroid;
}
