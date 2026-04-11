// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PostsNotifier)
final postsProvider = PostsNotifierProvider._();

final class PostsNotifierProvider
    extends $AsyncNotifierProvider<PostsNotifier, PostsState> {
  PostsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'postsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$postsNotifierHash();

  @$internal
  @override
  PostsNotifier create() => PostsNotifier();
}

String _$postsNotifierHash() => r'ea493455c4d8495b4bf1e43c3f00be269cbea605';

abstract class _$PostsNotifier extends $AsyncNotifier<PostsState> {
  FutureOr<PostsState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<PostsState>, PostsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PostsState>, PostsState>,
              AsyncValue<PostsState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
