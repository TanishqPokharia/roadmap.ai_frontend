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
    r'081d815d18aac291c40dbe214f5a5aab357b4bf1';

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
