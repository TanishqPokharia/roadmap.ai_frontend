// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_attach_interceptor.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(tokenAttachInterceptor)
final tokenAttachInterceptorProvider = TokenAttachInterceptorProvider._();

final class TokenAttachInterceptorProvider
    extends
        $FunctionalProvider<
          TokenAttachInterceptor,
          TokenAttachInterceptor,
          TokenAttachInterceptor
        >
    with $Provider<TokenAttachInterceptor> {
  TokenAttachInterceptorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tokenAttachInterceptorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tokenAttachInterceptorHash();

  @$internal
  @override
  $ProviderElement<TokenAttachInterceptor> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TokenAttachInterceptor create(Ref ref) {
    return tokenAttachInterceptor(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TokenAttachInterceptor value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TokenAttachInterceptor>(value),
    );
  }
}

String _$tokenAttachInterceptorHash() =>
    r'443f87a34760d04572e4f48caf987670fbb785b6';
