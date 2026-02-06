// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_roadmap_subgoal_status.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(updateRoadmapSubgoalStatus)
final updateRoadmapSubgoalStatusProvider =
    UpdateRoadmapSubgoalStatusProvider._();

final class UpdateRoadmapSubgoalStatusProvider
    extends
        $FunctionalProvider<
          UpdateRoadmapSubgoalStatus,
          UpdateRoadmapSubgoalStatus,
          UpdateRoadmapSubgoalStatus
        >
    with $Provider<UpdateRoadmapSubgoalStatus> {
  UpdateRoadmapSubgoalStatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateRoadmapSubgoalStatusProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateRoadmapSubgoalStatusHash();

  @$internal
  @override
  $ProviderElement<UpdateRoadmapSubgoalStatus> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UpdateRoadmapSubgoalStatus create(Ref ref) {
    return updateRoadmapSubgoalStatus(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateRoadmapSubgoalStatus value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateRoadmapSubgoalStatus>(value),
    );
  }
}

String _$updateRoadmapSubgoalStatusHash() =>
    r'48c7b969ff10f3fae11df911f12556c46d696192';
