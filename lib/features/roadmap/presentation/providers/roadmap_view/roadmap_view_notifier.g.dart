// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roadmap_view_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$roadmapViewNotifierHash() =>
    r'08b6a395330fae1167c1d1e97f394cd8142302cc';

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

abstract class _$RoadmapViewNotifier
    extends BuildlessAutoDisposeAsyncNotifier<Roadmap> {
  late final String roadmapId;

  FutureOr<Roadmap> build(String roadmapId);
}

/// See also [RoadmapViewNotifier].
@ProviderFor(RoadmapViewNotifier)
const roadmapViewNotifierProvider = RoadmapViewNotifierFamily();

/// See also [RoadmapViewNotifier].
class RoadmapViewNotifierFamily extends Family<AsyncValue<Roadmap>> {
  /// See also [RoadmapViewNotifier].
  const RoadmapViewNotifierFamily();

  /// See also [RoadmapViewNotifier].
  RoadmapViewNotifierProvider call(String roadmapId) {
    return RoadmapViewNotifierProvider(roadmapId);
  }

  @override
  RoadmapViewNotifierProvider getProviderOverride(
    covariant RoadmapViewNotifierProvider provider,
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
  String? get name => r'roadmapViewNotifierProvider';
}

/// See also [RoadmapViewNotifier].
class RoadmapViewNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<RoadmapViewNotifier, Roadmap> {
  /// See also [RoadmapViewNotifier].
  RoadmapViewNotifierProvider(String roadmapId)
    : this._internal(
        () => RoadmapViewNotifier()..roadmapId = roadmapId,
        from: roadmapViewNotifierProvider,
        name: r'roadmapViewNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$roadmapViewNotifierHash,
        dependencies: RoadmapViewNotifierFamily._dependencies,
        allTransitiveDependencies:
            RoadmapViewNotifierFamily._allTransitiveDependencies,
        roadmapId: roadmapId,
      );

  RoadmapViewNotifierProvider._internal(
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
  FutureOr<Roadmap> runNotifierBuild(covariant RoadmapViewNotifier notifier) {
    return notifier.build(roadmapId);
  }

  @override
  Override overrideWith(RoadmapViewNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: RoadmapViewNotifierProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<RoadmapViewNotifier, Roadmap>
  createElement() {
    return _RoadmapViewNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RoadmapViewNotifierProvider && other.roadmapId == roadmapId;
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
mixin RoadmapViewNotifierRef on AutoDisposeAsyncNotifierProviderRef<Roadmap> {
  /// The parameter `roadmapId` of this provider.
  String get roadmapId;
}

class _RoadmapViewNotifierProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<RoadmapViewNotifier, Roadmap>
    with RoadmapViewNotifierRef {
  _RoadmapViewNotifierProviderElement(super.provider);

  @override
  String get roadmapId => (origin as RoadmapViewNotifierProvider).roadmapId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
