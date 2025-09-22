// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_post_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$createPostNotifierHash() =>
    r'c342e4f41898e6568b5a011d380287478716be49';

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

abstract class _$CreatePostNotifier
    extends BuildlessAutoDisposeAsyncNotifier<CreatePostState> {
  late final String roadmapId;

  FutureOr<CreatePostState> build(String roadmapId);
}

/// See also [CreatePostNotifier].
@ProviderFor(CreatePostNotifier)
const createPostNotifierProvider = CreatePostNotifierFamily();

/// See also [CreatePostNotifier].
class CreatePostNotifierFamily extends Family<AsyncValue<CreatePostState>> {
  /// See also [CreatePostNotifier].
  const CreatePostNotifierFamily();

  /// See also [CreatePostNotifier].
  CreatePostNotifierProvider call(String roadmapId) {
    return CreatePostNotifierProvider(roadmapId);
  }

  @override
  CreatePostNotifierProvider getProviderOverride(
    covariant CreatePostNotifierProvider provider,
  ) {
    return call(provider.roadmapId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'createPostNotifierProvider';
}

/// See also [CreatePostNotifier].
class CreatePostNotifierProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          CreatePostNotifier,
          CreatePostState
        > {
  /// See also [CreatePostNotifier].
  CreatePostNotifierProvider(String roadmapId)
    : this._internal(
        () => CreatePostNotifier()..roadmapId = roadmapId,
        from: createPostNotifierProvider,
        name: r'createPostNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$createPostNotifierHash,
        dependencies: CreatePostNotifierFamily._dependencies,
        allTransitiveDependencies:
            CreatePostNotifierFamily._allTransitiveDependencies,
        roadmapId: roadmapId,
      );

  CreatePostNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.roadmapId,
  }) : super.internal();

  final String roadmapId;

  @override
  FutureOr<CreatePostState> runNotifierBuild(
    covariant CreatePostNotifier notifier,
  ) {
    return notifier.build(roadmapId);
  }

  @override
  Override overrideWith(CreatePostNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: CreatePostNotifierProvider._internal(
        () => create()..roadmapId = roadmapId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        roadmapId: roadmapId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<CreatePostNotifier, CreatePostState>
  createElement() {
    return _CreatePostNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CreatePostNotifierProvider && other.roadmapId == roadmapId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, roadmapId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CreatePostNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<CreatePostState> {
  /// The parameter `roadmapId` of this provider.
  String get roadmapId;
}

class _CreatePostNotifierProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          CreatePostNotifier,
          CreatePostState
        >
    with CreatePostNotifierRef {
  _CreatePostNotifierProviderElement(super.provider);

  @override
  String get roadmapId => (origin as CreatePostNotifierProvider).roadmapId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
