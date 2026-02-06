// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_filter_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PostsFilter)
final postsFilterProvider = PostsFilterProvider._();

final class PostsFilterProvider
    extends $NotifierProvider<PostsFilter, PostFilter> {
  PostsFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'postsFilterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$postsFilterHash();

  @$internal
  @override
  PostsFilter create() => PostsFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PostFilter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PostFilter>(value),
    );
  }
}

String _$postsFilterHash() => r'894aafbfd762af69713fb68e73384c0523cda149';

abstract class _$PostsFilter extends $Notifier<PostFilter> {
  PostFilter build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<PostFilter, PostFilter>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PostFilter, PostFilter>,
              PostFilter,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
