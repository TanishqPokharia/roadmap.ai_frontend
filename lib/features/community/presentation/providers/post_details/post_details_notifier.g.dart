// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_details_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$postDetailsNotifierHash() =>
    r'e258f0344b9dad1c6f9d6b31dc269b85338d10cf';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$PostDetailsNotifier
    extends BuildlessAutoDisposeAsyncNotifier<PostDetails> {
  late final String postId;

  FutureOr<PostDetails> build(String postId);
}

/// See also [PostDetailsNotifier].
@ProviderFor(PostDetailsNotifier)
const postDetailsNotifierProvider = PostDetailsNotifierFamily();

/// See also [PostDetailsNotifier].
class PostDetailsNotifierFamily extends Family<AsyncValue<PostDetails>> {
  /// See also [PostDetailsNotifier].
  const PostDetailsNotifierFamily();

  /// See also [PostDetailsNotifier].
  PostDetailsNotifierProvider call(String postId) {
    return PostDetailsNotifierProvider(postId);
  }

  @override
  PostDetailsNotifierProvider getProviderOverride(
    covariant PostDetailsNotifierProvider provider,
  ) {
    return call(provider.postId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'postDetailsNotifierProvider';
}

/// See also [PostDetailsNotifier].
class PostDetailsNotifierProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<PostDetailsNotifier, PostDetails> {
  /// See also [PostDetailsNotifier].
  PostDetailsNotifierProvider(String postId)
    : this._internal(
        () => PostDetailsNotifier()..postId = postId,
        from: postDetailsNotifierProvider,
        name: r'postDetailsNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$postDetailsNotifierHash,
        dependencies: PostDetailsNotifierFamily._dependencies,
        allTransitiveDependencies:
            PostDetailsNotifierFamily._allTransitiveDependencies,
        postId: postId,
      );

  PostDetailsNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.postId,
  }) : super.internal();

  final String postId;

  @override
  FutureOr<PostDetails> runNotifierBuild(
    covariant PostDetailsNotifier notifier,
  ) {
    return notifier.build(postId);
  }

  @override
  Override overrideWith(PostDetailsNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: PostDetailsNotifierProvider._internal(
        () => create()..postId = postId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        postId: postId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<PostDetailsNotifier, PostDetails>
  createElement() {
    return _PostDetailsNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PostDetailsNotifierProvider && other.postId == postId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, postId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PostDetailsNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<PostDetails> {
  /// The parameter `postId` of this provider.
  String get postId;
}

class _PostDetailsNotifierProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          PostDetailsNotifier,
          PostDetails
        >
    with PostDetailsNotifierRef {
  _PostDetailsNotifierProviderElement(super.provider);

  @override
  String get postId => (origin as PostDetailsNotifierProvider).postId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
