// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_post_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CreatePostNotifier)
final createPostProvider = CreatePostNotifierFamily._();

final class CreatePostNotifierProvider
    extends $AsyncNotifierProvider<CreatePostNotifier, CreatePostState> {
  CreatePostNotifierProvider._({
    required CreatePostNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'createPostProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$createPostNotifierHash();

  @override
  String toString() {
    return r'createPostProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CreatePostNotifier create() => CreatePostNotifier();

  @override
  bool operator ==(Object other) {
    return other is CreatePostNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$createPostNotifierHash() =>
    r'a64986828c6b274f1ec80f284ba4f2bf6a8f5137';

final class CreatePostNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          CreatePostNotifier,
          AsyncValue<CreatePostState>,
          CreatePostState,
          FutureOr<CreatePostState>,
          String
        > {
  CreatePostNotifierFamily._()
    : super(
        retry: null,
        name: r'createPostProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CreatePostNotifierProvider call(String roadmapId) =>
      CreatePostNotifierProvider._(argument: roadmapId, from: this);

  @override
  String toString() => r'createPostProvider';
}

abstract class _$CreatePostNotifier extends $AsyncNotifier<CreatePostState> {
  late final _$args = ref.$arg as String;
  String get roadmapId => _$args;

  FutureOr<CreatePostState> build(String roadmapId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<CreatePostState>, CreatePostState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CreatePostState>, CreatePostState>,
              AsyncValue<CreatePostState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
