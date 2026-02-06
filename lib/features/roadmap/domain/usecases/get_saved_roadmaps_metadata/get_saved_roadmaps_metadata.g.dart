// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_saved_roadmaps_metadata.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getSavedRoadmapsMetadata)
final getSavedRoadmapsMetadataProvider = GetSavedRoadmapsMetadataProvider._();

final class GetSavedRoadmapsMetadataProvider
    extends
        $FunctionalProvider<
          GetSavedRoadmapsMetadata,
          GetSavedRoadmapsMetadata,
          GetSavedRoadmapsMetadata
        >
    with $Provider<GetSavedRoadmapsMetadata> {
  GetSavedRoadmapsMetadataProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getSavedRoadmapsMetadataProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getSavedRoadmapsMetadataHash();

  @$internal
  @override
  $ProviderElement<GetSavedRoadmapsMetadata> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetSavedRoadmapsMetadata create(Ref ref) {
    return getSavedRoadmapsMetadata(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetSavedRoadmapsMetadata value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetSavedRoadmapsMetadata>(value),
    );
  }
}

String _$getSavedRoadmapsMetadataHash() =>
    r'c604c2f2b565064faf054a4ab797e99beb73e6d2';
