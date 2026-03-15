import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/common/dio/dio_adapter_stub.dart'
    if (dart.library.html) 'package:roadmap_ai/core/common/dio/dio_adapter_web.dart';
import 'package:roadmap_ai/core/common/token_storage/flutter_secure_storage_token_storage_impl.dart';
import 'package:roadmap_ai/core/common/token_storage/token_storage.dart';
import 'package:roadmap_ai/core/constants/api_config.dart';
import 'package:roadmap_ai/features/auth/data/models/tokens/tokens.dart';

part 'refresh_token_interceptor.g.dart';

@riverpod
RefreshTokenInterceptor refreshTokenInterceptor(Ref ref) {
  // Create a separate Dio instance specifically for the interceptor
  // This breaks the circular dependency
  final interceptorDio = Dio(
    BaseOptions(
      baseUrl: '${ApiConfig.baseUrl}/api/v1',
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      validateStatus: (status) => true,
      contentType: 'application/json',
    ),
  );

  // Configure platform-specific adapter
  configureDioAdapter(interceptorDio);

  return RefreshTokenInterceptor(
    ref.read(tokenStorageProvider),
    interceptorDio,
  );
}

class RefreshTokenInterceptor extends Interceptor {
  final TokenStorage tokenStorage;
  final Dio _dio;

  // Prevent multiple concurrent refresh attempts
  static bool _isRefreshing = false;
  static final List<Completer<bool>> _refreshCompleters = [];

  RefreshTokenInterceptor(this.tokenStorage, this._dio);

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    try {
      if (!_shouldRefreshToken(response)) {
        handler.next(response);
        return;
      }

      // Attempt to refresh tokens and retry the request
      final success = await _handleTokenRefreshAndRetry(
        response.requestOptions,
      );

      if (success != null) {
        handler.resolve(success);
      } else {
        // Pass original response if refresh/retry failed
        handler.next(response);
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        log(
          'Error in refresh token interceptor',
          error: e,
          stackTrace: stackTrace,
        );
      }
      handler.next(response);
    }
  }

  /// Handles the entire token refresh and retry flow
  /// Returns the successful response or null if failed
  Future<Response?> _handleTokenRefreshAndRetry(
    RequestOptions originalRequest,
  ) async {
    try {
      // Prevent multiple concurrent refresh attempts
      if (_isRefreshing) {
        // Become a waiter and wait for the ongoing refresh to complete
        final completer = Completer<bool>();
        _refreshCompleters.add(completer);
        final refreshSuccess = await completer
            .future; // this waits for the leader request to finish token refresh

        if (!refreshSuccess) return null;
      } else {
        // Become the leader and perform the refresh
        _isRefreshing = true;
        final refreshSuccess = await _refreshTokens();

        // Notify all waiting requests of the result so they can continue their execution
        for (final completer in _refreshCompleters) {
          completer.complete(refreshSuccess);
        }
        _refreshCompleters.clear();
        _isRefreshing = false;

        if (!refreshSuccess) return null;
      }

      // Prepare request with new token
      final updatedRequest = await _prepareRequestWithNewToken(originalRequest);
      if (updatedRequest == null) return null;

      // Retry the request
      return await _dio.fetch(updatedRequest);
    } catch (e, stackTrace) {
      // Reset refresh state on error
      if (_isRefreshing) {
        for (final completer in _refreshCompleters) {
          completer.complete(false);
        }
        _refreshCompleters.clear();
        _isRefreshing = false;
      }

      if (kDebugMode) {
        log('Token refresh and retry failed', error: e, stackTrace: stackTrace);
      }
      return null;
    }
  }

  /// Self-contained refresh tokens logic - no external dependencies
  Future<bool> _refreshTokens() async {
    try {
      if (kIsWeb) {
        return await _refreshTokensWeb();
      } else {
        return await _refreshTokensMobile();
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        log('Token refresh failed', error: e, stackTrace: stackTrace);
      }
      return false;
    }
  }

  /// Mobile refresh tokens implementation
  Future<bool> _refreshTokensMobile() async {
    try {
      // Get current refresh token from storage
      final tokensResult = await tokenStorage.getTokens().run();
      final refreshToken = tokensResult.fold((failure) {
        if (kDebugMode) log('Failed to get tokens from storage: $failure');
        return null;
      }, (tokens) => tokens?.refreshToken);

      if (refreshToken == null) {
        if (kDebugMode) log('No refresh token available');
        return false;
      }

      // Make refresh request with timeout
      final response = await _dio.post(
        '/auth/refresh',
        options: Options(
          headers: {
            'Authorization': 'Bearer $refreshToken',
            'X-Client-OS': 'android',
          },
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        // Parse new tokens
        final data = response.data as Map<String, dynamic>;
        final tokensModel = TokensModel.fromJson(data);

        // Save new tokens to storage
        final saveResult = await tokenStorage
            .saveTokens(
              accessToken: tokensModel.accessToken,
              refreshToken: tokensModel.refreshToken,
            )
            .run();

        final success = saveResult.isRight();
        if (!success) {
          if (kDebugMode) log('Failed to save new tokens to storage');
        }
        return success;
      } else {
        if (kDebugMode) {
          log('Refresh request failed with status: ${response.statusCode}');
        }
        return false;
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        log('Mobile token refresh failed', error: e, stackTrace: stackTrace);
      }
      return false;
    }
  }

  /// Web refresh tokens implementation
  Future<bool> _refreshTokensWeb() async {
    try {
      if (kDebugMode) log("INITIALIZING COOKIE REFRESH");
      final response = await _dio.post('/auth/refresh');
      return response.statusCode == 200;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        log('Web token refresh failed', error: e, stackTrace: stackTrace);
      }
      return false;
    }
  }

  /// Updates request headers with new token for mobile, returns original for web
  Future<RequestOptions?> _prepareRequestWithNewToken(
    RequestOptions original,
  ) async {
    if (kIsWeb) {
      return original; // Web uses cookies, no header modification needed
    }

    final tokensResult = await tokenStorage.getTokens().run();
    return tokensResult.fold(
      (_) => null, // Failed to get tokens
      (tokens) {
        if (tokens == null) return null;

        return original.copyWith(
          headers: {
            ...original.headers,
            'Authorization': 'Bearer ${tokens.accessToken}',
          },
        );
      },
    );
  }

  bool _shouldRefreshToken(Response response) {
    // Only attempt refresh on 401 Unauthorized responses
    if (response.statusCode != 401) return false;

    // Check error message for token-related issues, default to true for 401s
    final responseData = response.data;
    if (responseData is Map<String, dynamic>) {
      final errorMessage =
          responseData['error']?.toString().toLowerCase() ?? '';

      // Don't refresh if it's explicitly not a token issue
      if (errorMessage.contains('invalid credentials') ||
          errorMessage.contains('wrong password')) {
        if (kDebugMode) log('Not attempting refresh - invalid credentials');
        return false;
      }

      // Refresh for token-related errors or empty error
      return errorMessage.isEmpty ||
          errorMessage.contains('expire') ||
          errorMessage.contains('token');
    }

    return true; // Treat any 401 as token issue if no specific error info
  }
}
