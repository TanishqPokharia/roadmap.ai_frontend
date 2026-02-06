// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_roadmap.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(saveRoadmap)
final saveRoadmapProvider = SaveRoadmapProvider._();

final class SaveRoadmapProvider
    extends $FunctionalProvider<SaveRoadmap, SaveRoadmap, SaveRoadmap>
    with $Provider<SaveRoadmap> {
  SaveRoadmapProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'saveRoadmapProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$saveRoadmapHash();

  @$internal
  @override
  $ProviderElement<SaveRoadmap> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SaveRoadmap create(Ref ref) {
    return saveRoadmap(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SaveRoadmap value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SaveRoadmap>(value),
    );
  }
}

String _$saveRoadmapHash() => r'aa23a4fc9edc5587ca2e9d3041bcd89fba1441d6';
