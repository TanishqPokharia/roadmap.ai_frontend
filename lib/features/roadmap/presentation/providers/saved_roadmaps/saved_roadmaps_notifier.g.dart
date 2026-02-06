// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_roadmaps_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SavedRoadmapsNotifier)
final savedRoadmapsProvider = SavedRoadmapsNotifierProvider._();

final class SavedRoadmapsNotifierProvider
    extends $AsyncNotifierProvider<SavedRoadmapsNotifier, SavedRoadmapsState> {
  SavedRoadmapsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'savedRoadmapsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$savedRoadmapsNotifierHash();

  @$internal
  @override
  SavedRoadmapsNotifier create() => SavedRoadmapsNotifier();
}

String _$savedRoadmapsNotifierHash() =>
    r'6bb2f7ef52be783d40c3ecd2a4ff11585ccb4bda';

abstract class _$SavedRoadmapsNotifier
    extends $AsyncNotifier<SavedRoadmapsState> {
  FutureOr<SavedRoadmapsState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<SavedRoadmapsState>, SavedRoadmapsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SavedRoadmapsState>, SavedRoadmapsState>,
              AsyncValue<SavedRoadmapsState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
