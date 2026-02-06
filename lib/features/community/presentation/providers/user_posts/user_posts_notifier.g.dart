// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_posts_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserPostsNotifier)
final userPostsProvider = UserPostsNotifierProvider._();

final class UserPostsNotifierProvider
    extends $AsyncNotifierProvider<UserPostsNotifier, List<PostMetadata>> {
  UserPostsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userPostsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userPostsNotifierHash();

  @$internal
  @override
  UserPostsNotifier create() => UserPostsNotifier();
}

String _$userPostsNotifierHash() => r'5255078906759a0a59bfc3eed94f375090459c3d';

abstract class _$UserPostsNotifier extends $AsyncNotifier<List<PostMetadata>> {
  FutureOr<List<PostMetadata>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<PostMetadata>>, List<PostMetadata>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<PostMetadata>>, List<PostMetadata>>,
              AsyncValue<List<PostMetadata>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
