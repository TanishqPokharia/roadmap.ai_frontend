// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_roadmap_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$editRoadmapNotifierHash() =>
    r'33c4c9d2a3293620d8e937675f45c07edf0a0be9';

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

abstract class _$EditRoadmapNotifier
    extends BuildlessAutoDisposeNotifier<Roadmap> {
  late final Roadmap roadmap;

  Roadmap build(Roadmap roadmap);
}

/// See also [EditRoadmapNotifier].
@ProviderFor(EditRoadmapNotifier)
const editRoadmapNotifierProvider = EditRoadmapNotifierFamily();

/// See also [EditRoadmapNotifier].
class EditRoadmapNotifierFamily extends Family<Roadmap> {
  /// See also [EditRoadmapNotifier].
  const EditRoadmapNotifierFamily();

  /// See also [EditRoadmapNotifier].
  EditRoadmapNotifierProvider call(Roadmap roadmap) {
    return EditRoadmapNotifierProvider(roadmap);
  }

  @override
  EditRoadmapNotifierProvider getProviderOverride(
    covariant EditRoadmapNotifierProvider provider,
  ) {
    return call(provider.roadmap);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'editRoadmapNotifierProvider';
}

/// See also [EditRoadmapNotifier].
class EditRoadmapNotifierProvider
    extends AutoDisposeNotifierProviderImpl<EditRoadmapNotifier, Roadmap> {
  /// See also [EditRoadmapNotifier].
  EditRoadmapNotifierProvider(Roadmap roadmap)
    : this._internal(
        () => EditRoadmapNotifier()..roadmap = roadmap,
        from: editRoadmapNotifierProvider,
        name: r'editRoadmapNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$editRoadmapNotifierHash,
        dependencies: EditRoadmapNotifierFamily._dependencies,
        allTransitiveDependencies:
            EditRoadmapNotifierFamily._allTransitiveDependencies,
        roadmap: roadmap,
      );

  EditRoadmapNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.roadmap,
  }) : super.internal();

  final Roadmap roadmap;

  @override
  Roadmap runNotifierBuild(covariant EditRoadmapNotifier notifier) {
    return notifier.build(roadmap);
  }

  @override
  Override overrideWith(EditRoadmapNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: EditRoadmapNotifierProvider._internal(
        () => create()..roadmap = roadmap,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        roadmap: roadmap,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<EditRoadmapNotifier, Roadmap>
  createElement() {
    return _EditRoadmapNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EditRoadmapNotifierProvider && other.roadmap == roadmap;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, roadmap.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EditRoadmapNotifierRef on AutoDisposeNotifierProviderRef<Roadmap> {
  /// The parameter `roadmap` of this provider.
  Roadmap get roadmap;
}

class _EditRoadmapNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<EditRoadmapNotifier, Roadmap>
    with EditRoadmapNotifierRef {
  _EditRoadmapNotifierProviderElement(super.provider);

  @override
  Roadmap get roadmap => (origin as EditRoadmapNotifierProvider).roadmap;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
