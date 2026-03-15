import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/common/token_storage/flutter_secure_storage_token_storage_impl.dart';
import 'package:roadmap_ai/core/common/token_storage/token_storage.dart';

part 'token_attach_interceptor.g.dart';

@riverpod
TokenAttachInterceptor tokenAttachInterceptor(Ref ref) {
  return TokenAttachInterceptor(ref.read(tokenStorageProvider));
}

class TokenAttachInterceptor extends Interceptor {
  final TokenStorage tokenStorage;
  TokenAttachInterceptor(this.tokenStorage);
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.path.contains('login') ||
        options.path.contains('signup') ||
        options.path.contains('refresh')) {
      super.onRequest(options, handler);
      return;
    }

    final tokens = await tokenStorage.getTokens().run();
    tokens.fold(
      (l) {
        if (kDebugMode) log('No tokens found during interception: $l');
      },
      (r) {
        if (kDebugMode) log("Tokens found");
        options.headers['Authorization'] = 'Bearer ${r?.accessToken}';
      },
    );

    super.onRequest(options, handler);
  }
}
