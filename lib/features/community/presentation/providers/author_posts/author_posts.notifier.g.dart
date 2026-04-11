// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author_posts.notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AuthorPostsNotifier)
final authorPostsProvider = AuthorPostsNotifierFamily._();

final class AuthorPostsNotifierProvider
    extends $AsyncNotifierProvider<AuthorPostsNotifier, AuthorPostsState> {
  AuthorPostsNotifierProvider._({
    required AuthorPostsNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'authorPostsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$authorPostsNotifierHash();

  @override
  String toString() {
    return r'authorPostsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  AuthorPostsNotifier create() => AuthorPostsNotifier();

  @override
  bool operator ==(Object other) {
    return other is AuthorPostsNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$authorPostsNotifierHash() =>
    r'4ff66493f79846c040aaaa86a42ced1693664e59';

final class AuthorPostsNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          AuthorPostsNotifier,
          AsyncValue<AuthorPostsState>,
          AuthorPostsState,
          FutureOr<AuthorPostsState>,
          String
        > {
  AuthorPostsNotifierFamily._()
    : super(
        retry: null,
        name: r'authorPostsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AuthorPostsNotifierProvider call(String authorId) =>
      AuthorPostsNotifierProvider._(argument: authorId, from: this);

  @override
  String toString() => r'authorPostsProvider';
}

abstract class _$AuthorPostsNotifier extends $AsyncNotifier<AuthorPostsState> {
  late final _$args = ref.$arg as String;
  String get authorId => _$args;

  FutureOr<AuthorPostsState> build(String authorId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<AuthorPostsState>, AuthorPostsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AuthorPostsState>, AuthorPostsState>,
              AsyncValue<AuthorPostsState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
