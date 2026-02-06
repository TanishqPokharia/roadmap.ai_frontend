// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_posts_by_title.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getPostsByTitle)
final getPostsByTitleProvider = GetPostsByTitleProvider._();

final class GetPostsByTitleProvider
    extends
        $FunctionalProvider<GetPostsByTitle, GetPostsByTitle, GetPostsByTitle>
    with $Provider<GetPostsByTitle> {
  GetPostsByTitleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getPostsByTitleProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getPostsByTitleHash();

  @$internal
  @override
  $ProviderElement<GetPostsByTitle> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetPostsByTitle create(Ref ref) {
    return getPostsByTitle(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetPostsByTitle value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetPostsByTitle>(value),
    );
  }
}

String _$getPostsByTitleHash() => r'd3371b148f33c6c96bb25f0803c9c4bd76c25cfc';
