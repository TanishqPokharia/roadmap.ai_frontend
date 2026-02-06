// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_token_interceptor.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(refreshTokenInterceptor)
final refreshTokenInterceptorProvider = RefreshTokenInterceptorProvider._();

final class RefreshTokenInterceptorProvider
    extends
        $FunctionalProvider<
          RefreshTokenInterceptor,
          RefreshTokenInterceptor,
          RefreshTokenInterceptor
        >
    with $Provider<RefreshTokenInterceptor> {
  RefreshTokenInterceptorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'refreshTokenInterceptorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$refreshTokenInterceptorHash();

  @$internal
  @override
  $ProviderElement<RefreshTokenInterceptor> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RefreshTokenInterceptor create(Ref ref) {
    return refreshTokenInterceptor(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RefreshTokenInterceptor value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RefreshTokenInterceptor>(value),
    );
  }
}

String _$refreshTokenInterceptorHash() =>
    r'4ba689af60b049fd45aba1cfef892c7e687a96f9';
