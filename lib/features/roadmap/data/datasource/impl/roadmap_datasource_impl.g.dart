// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roadmap_datasource_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(roadmapDatasource)
final roadmapDatasourceProvider = RoadmapDatasourceProvider._();

final class RoadmapDatasourceProvider
    extends
        $FunctionalProvider<
          RoadmapDatasource,
          RoadmapDatasource,
          RoadmapDatasource
        >
    with $Provider<RoadmapDatasource> {
  RoadmapDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'roadmapDatasourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$roadmapDatasourceHash();

  @$internal
  @override
  $ProviderElement<RoadmapDatasource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RoadmapDatasource create(Ref ref) {
    return roadmapDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RoadmapDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RoadmapDatasource>(value),
    );
  }
}

String _$roadmapDatasourceHash() => r'a06aab5033cebacb685622c992bc65e7c4e3f09a';
