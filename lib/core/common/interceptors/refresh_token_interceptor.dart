import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/browser.dart';
import 'package:roadmap_ai/core/common/token_storage/flutter_secure_storage_token_storage_impl.dart';
import 'package:roadmap_ai/core/common/token_storage/token_storage.dart';
import 'package:roadmap_ai/features/auth/data/models/tokens/tokens.dart';

part 'refresh_token_interceptor.g.dart';

@riverpod
RefreshTokenInterceptor refreshTokenInterceptor(Ref ref) {
  // Create a separate Dio instance specifically for the interceptor
  // This breaks the circular dependency
  final interceptorDio = Dio(
    BaseOptions(
      baseUrl: dotenv.env['BASE_URL']!,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      validateStatus: (status) => true,
      contentType: 'application/json',
    ),
  );

  // Configure for web if needed
  if (kIsWeb) {
    final browserAdapter = BrowserHttpClientAdapter()..withCredentials = true;
    interceptorDio.httpClientAdapter = browserAdapter;
    interceptorDio.options.headers['withCredentials'] = true;
  }

  return RefreshTokenInterceptor(
    ref.read(tokenStorageProvider),
    interceptorDio,
  );
}

class RefreshTokenInterceptor extends Interceptor {
  final TokenStorage tokenStorage;
  final Dio _dio;

  RefreshTokenInterceptor(this.tokenStorage, this._dio);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (!_shouldRefreshToken(err)) {
      handler.next(err);
      return;
    }

    // Attempt to refresh tokens and retry the request
    final success = await _handleTokenRefreshAndRetry(err.requestOptions);

    if (success != null) {
      handler.resolve(success);
    } else {
      handler.next(err); // Pass original error if refresh/retry failed
    }
  }

  /// Handles the entire token refresh and retry flow
  /// Returns the successful response or null if failed
  Future<Response?> _handleTokenRefreshAndRetry(
    RequestOptions originalRequest,
  ) async {
    // Step 1: Refresh tokens using self-contained logic
    final refreshSuccess = await _refreshTokens();
    if (!refreshSuccess) return null;

    // Step 2: Prepare request with new token (mobile only)
    final updatedRequest = await _prepareRequestWithNewToken(originalRequest);
    if (updatedRequest == null) return null;

    // Step 3: Retry the request
    try {
      return await _dio.fetch(updatedRequest);
    } catch (_) {
      return null; // Retry failed
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
    } catch (e) {
      return false;
    }
  }

  /// Mobile refresh tokens implementation
  Future<bool> _refreshTokensMobile() async {
    try {
      // Get current refresh token from storage
      final tokensResult = await tokenStorage.getTokens().run();
      final refreshToken = tokensResult.fold(
        (_) => null,
        (tokens) => tokens?.refreshToken,
      );

      if (refreshToken == null) {
        return false;
      }

      // Make refresh request
      final response = await _dio.post(
        '/auth/refresh',
        options: Options(headers: {'Authorization': 'Bearer $refreshToken'}),
      );

      if (response.statusCode == 200) {
        // Parse new tokens
        final data = response.data;
        final tokensModel = TokensModel.fromJson(data);

        // Save new tokens to storage
        final saveResult = await tokenStorage
            .saveTokens(
              accessToken: tokensModel.accessToken,
              refreshToken: tokensModel.refreshToken,
            )
            .run();

        return saveResult.isRight();
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Web refresh tokens implementation
  Future<bool> _refreshTokensWeb() async {
    try {
      final response = await _dio.post('/auth/refresh');
      return response.statusCode == 200;
    } catch (e) {
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

  bool _shouldRefreshToken(DioException err) {
    if (err.response?.statusCode != 401) return false;

    // Check error message for token-related issues, default to true for 401s
    final responseData = err.response?.data;
    if (responseData is Map<String, dynamic>) {
      final errorMessage =
          responseData['error']?.toString().toLowerCase() ?? '';
      return errorMessage.isEmpty ||
          errorMessage.contains('expire') ||
          errorMessage.contains('token');
    }

    return true; // Treat any 401 as token issue
  }
}
