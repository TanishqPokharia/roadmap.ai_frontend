// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'explore_page_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$explorePageNotifierHash() =>
    r'a544094b7056d296fa7c775310256c8f467a15df';

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

abstract class _$ExplorePageNotifier
    extends BuildlessAutoDisposeAsyncNotifier<PopularPostState> {
  late final int limit;
  late final int skip;

  FutureOr<PopularPostState> build({required int limit, required int skip});
}

/// See also [ExplorePageNotifier].
@ProviderFor(ExplorePageNotifier)
const explorePageNotifierProvider = ExplorePageNotifierFamily();

/// See also [ExplorePageNotifier].
class ExplorePageNotifierFamily extends Family<AsyncValue<PopularPostState>> {
  /// See also [ExplorePageNotifier].
  const ExplorePageNotifierFamily();

  /// See also [ExplorePageNotifier].
  ExplorePageNotifierProvider call({required int limit, required int skip}) {
    return ExplorePageNotifierProvider(limit: limit, skip: skip);
  }

  @override
  ExplorePageNotifierProvider getProviderOverride(
    covariant ExplorePageNotifierProvider provider,
  ) {
    return call(limit: provider.limit, skip: provider.skip);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'explorePageNotifierProvider';
}

/// See also [ExplorePageNotifier].
class ExplorePageNotifierProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          ExplorePageNotifier,
          PopularPostState
        > {
  /// See also [ExplorePageNotifier].
  ExplorePageNotifierProvider({required int limit, required int skip})
    : this._internal(
        () => ExplorePageNotifier()
          ..limit = limit
          ..skip = skip,
        from: explorePageNotifierProvider,
        name: r'explorePageNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$explorePageNotifierHash,
        dependencies: ExplorePageNotifierFamily._dependencies,
        allTransitiveDependencies:
            ExplorePageNotifierFamily._allTransitiveDependencies,
        limit: limit,
        skip: skip,
      );

  ExplorePageNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.limit,
    required this.skip,
  }) : super.internal();

  final int limit;
  final int skip;

  @override
  FutureOr<PopularPostState> runNotifierBuild(
    covariant ExplorePageNotifier notifier,
  ) {
    return notifier.build(limit: limit, skip: skip);
  }

  @override
  Override overrideWith(ExplorePageNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: ExplorePageNotifierProvider._internal(
        () => create()
          ..limit = limit
          ..skip = skip,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        limit: limit,
        skip: skip,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ExplorePageNotifier, PopularPostState>
  createElement() {
    return _ExplorePageNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ExplorePageNotifierProvider &&
        other.limit == limit &&
        other.skip == skip;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);
    hash = _SystemHash.combine(hash, skip.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ExplorePageNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<PopularPostState> {
  /// The parameter `limit` of this provider.
  int get limit;

  /// The parameter `skip` of this provider.
  int get skip;
}

class _ExplorePageNotifierProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          ExplorePageNotifier,
          PopularPostState
        >
    with ExplorePageNotifierRef {
  _ExplorePageNotifierProviderElement(super.provider);

  @override
  int get limit => (origin as ExplorePageNotifierProvider).limit;
  @override
  int get skip => (origin as ExplorePageNotifierProvider).skip;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
