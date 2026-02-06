// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roadmap_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(roadmapRepository)
final roadmapRepositoryProvider = RoadmapRepositoryProvider._();

final class RoadmapRepositoryProvider
    extends
        $FunctionalProvider<
          RoadmapRepository,
          RoadmapRepository,
          RoadmapRepository
        >
    with $Provider<RoadmapRepository> {
  RoadmapRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'roadmapRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$roadmapRepositoryHash();

  @$internal
  @override
  $ProviderElement<RoadmapRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RoadmapRepository create(Ref ref) {
    return roadmapRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RoadmapRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RoadmapRepository>(value),
    );
  }
}

String _$roadmapRepositoryHash() => r'd80f6bbe83e80b7b109fa8c846a728c14fbe469c';
