// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate_roadmap.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(generateRoadmap)
final generateRoadmapProvider = GenerateRoadmapProvider._();

final class GenerateRoadmapProvider
    extends
        $FunctionalProvider<GenerateRoadmap, GenerateRoadmap, GenerateRoadmap>
    with $Provider<GenerateRoadmap> {
  GenerateRoadmapProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'generateRoadmapProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$generateRoadmapHash();

  @$internal
  @override
  $ProviderElement<GenerateRoadmap> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GenerateRoadmap create(Ref ref) {
    return generateRoadmap(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GenerateRoadmap value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GenerateRoadmap>(value),
    );
  }
}

String _$generateRoadmapHash() => r'be633aa785472ed596bdc9755a229843457ec171';
