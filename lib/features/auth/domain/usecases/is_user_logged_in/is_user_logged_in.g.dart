// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'is_user_logged_in.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(isUserLoggedIn)
final isUserLoggedInProvider = IsUserLoggedInProvider._();

final class IsUserLoggedInProvider
    extends $FunctionalProvider<IsUserLoggedIn, IsUserLoggedIn, IsUserLoggedIn>
    with $Provider<IsUserLoggedIn> {
  IsUserLoggedInProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isUserLoggedInProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isUserLoggedInHash();

  @$internal
  @override
  $ProviderElement<IsUserLoggedIn> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  IsUserLoggedIn create(Ref ref) {
    return isUserLoggedIn(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IsUserLoggedIn value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IsUserLoggedIn>(value),
    );
  }
}

String _$isUserLoggedInHash() => r'c4c0fef70963694b5e0c9b2ed32882c9dfe9dec7';
