// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_post_roadmap.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(savePostRoadmap)
final savePostRoadmapProvider = SavePostRoadmapProvider._();

final class SavePostRoadmapProvider
    extends
        $FunctionalProvider<SavePostRoadmap, SavePostRoadmap, SavePostRoadmap>
    with $Provider<SavePostRoadmap> {
  SavePostRoadmapProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'savePostRoadmapProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$savePostRoadmapHash();

  @$internal
  @override
  $ProviderElement<SavePostRoadmap> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SavePostRoadmap create(Ref ref) {
    return savePostRoadmap(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SavePostRoadmap value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SavePostRoadmap>(value),
    );
  }
}

String _$savePostRoadmapHash() => r'58e982446bad47ba95070ef7c94f14584f6e4190';
