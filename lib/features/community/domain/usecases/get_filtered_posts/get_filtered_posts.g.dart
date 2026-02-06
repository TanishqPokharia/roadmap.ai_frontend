// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_filtered_posts.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getFilteredPosts)
final getFilteredPostsProvider = GetFilteredPostsProvider._();

final class GetFilteredPostsProvider
    extends
        $FunctionalProvider<
          GetFilteredPosts,
          GetFilteredPosts,
          GetFilteredPosts
        >
    with $Provider<GetFilteredPosts> {
  GetFilteredPostsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getFilteredPostsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getFilteredPostsHash();

  @$internal
  @override
  $ProviderElement<GetFilteredPosts> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetFilteredPosts create(Ref ref) {
    return getFilteredPosts(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetFilteredPosts value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetFilteredPosts>(value),
    );
  }
}

String _$getFilteredPostsHash() => r'dda0576c33456076e16283f28ac15072654196d8';
