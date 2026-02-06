// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flutter_secure_storage_token_storage_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(tokenStorage)
final tokenStorageProvider = TokenStorageProvider._();

final class TokenStorageProvider
    extends
        $FunctionalProvider<
          FlutterSecureStorageTokenStorageImpl,
          FlutterSecureStorageTokenStorageImpl,
          FlutterSecureStorageTokenStorageImpl
        >
    with $Provider<FlutterSecureStorageTokenStorageImpl> {
  TokenStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tokenStorageProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tokenStorageHash();

  @$internal
  @override
  $ProviderElement<FlutterSecureStorageTokenStorageImpl> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FlutterSecureStorageTokenStorageImpl create(Ref ref) {
    return tokenStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FlutterSecureStorageTokenStorageImpl value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<FlutterSecureStorageTokenStorageImpl>(value),
    );
  }
}

String _$tokenStorageHash() => r'72d11befd4f7fd2aef1d1ad968e4a943472221a5';
