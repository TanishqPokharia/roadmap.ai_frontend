// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_roadmap_by_id.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getRoadmapById)
final getRoadmapByIdProvider = GetRoadmapByIdProvider._();

final class GetRoadmapByIdProvider
    extends $FunctionalProvider<GetRoadmapById, GetRoadmapById, GetRoadmapById>
    with $Provider<GetRoadmapById> {
  GetRoadmapByIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getRoadmapByIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getRoadmapByIdHash();

  @$internal
  @override
  $ProviderElement<GetRoadmapById> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetRoadmapById create(Ref ref) {
    return getRoadmapById(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetRoadmapById value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetRoadmapById>(value),
    );
  }
}

String _$getRoadmapByIdHash() => r'7f355e4ca7b65f5d31c751029ab44083b09b5f81';
