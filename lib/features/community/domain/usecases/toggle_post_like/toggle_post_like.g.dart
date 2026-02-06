// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toggle_post_like.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(togglePostLike)
final togglePostLikeProvider = TogglePostLikeProvider._();

final class TogglePostLikeProvider
    extends $FunctionalProvider<TogglePostLike, TogglePostLike, TogglePostLike>
    with $Provider<TogglePostLike> {
  TogglePostLikeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'togglePostLikeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$togglePostLikeHash();

  @$internal
  @override
  $ProviderElement<TogglePostLike> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TogglePostLike create(Ref ref) {
    return togglePostLike(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TogglePostLike value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TogglePostLike>(value),
    );
  }
}

String _$togglePostLikeHash() => r'f0017ef693b1a9a526732cb53b43be46f1a4f140';
