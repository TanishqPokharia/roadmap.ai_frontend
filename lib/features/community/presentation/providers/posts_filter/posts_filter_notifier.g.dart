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
    extends $NotifierProvider<PostsFilter, PostsFilterState> {
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
  Override overrideWithValue(PostsFilterState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PostsFilterState>(value),
    );
  }
}

String _$postsFilterHash() => r'6dc4b52426c610057cc40af3a6bba11630678c59';

abstract class _$PostsFilter extends $Notifier<PostsFilterState> {
  PostsFilterState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<PostsFilterState, PostsFilterState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PostsFilterState, PostsFilterState>,
              PostsFilterState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
