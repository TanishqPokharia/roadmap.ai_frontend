// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_details_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PostDetailsNotifier)
final postDetailsProvider = PostDetailsNotifierFamily._();

final class PostDetailsNotifierProvider
    extends $AsyncNotifierProvider<PostDetailsNotifier, PostDetailsState> {
  PostDetailsNotifierProvider._({
    required PostDetailsNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: _disableRetry,
         name: r'postDetailsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$postDetailsNotifierHash();

  @override
  String toString() {
    return r'postDetailsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PostDetailsNotifier create() => PostDetailsNotifier();

  @override
  bool operator ==(Object other) {
    return other is PostDetailsNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$postDetailsNotifierHash() =>
    r'9acbbf6f91b2a87dbb38d5debdab69c03ca831fc';

final class PostDetailsNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          PostDetailsNotifier,
          AsyncValue<PostDetailsState>,
          PostDetailsState,
          FutureOr<PostDetailsState>,
          String
        > {
  PostDetailsNotifierFamily._()
    : super(
        retry: _disableRetry,
        name: r'postDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PostDetailsNotifierProvider call(String postId) =>
      PostDetailsNotifierProvider._(argument: postId, from: this);

  @override
  String toString() => r'postDetailsProvider';
}

abstract class _$PostDetailsNotifier extends $AsyncNotifier<PostDetailsState> {
  late final _$args = ref.$arg as String;
  String get postId => _$args;

  FutureOr<PostDetailsState> build(String postId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<PostDetailsState>, PostDetailsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PostDetailsState>, PostDetailsState>,
              AsyncValue<PostDetailsState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
