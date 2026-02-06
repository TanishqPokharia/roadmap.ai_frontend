// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_roadmap_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SaveRoadmapNotifier)
final saveRoadmapProvider = SaveRoadmapNotifierProvider._();

final class SaveRoadmapNotifierProvider
    extends $AsyncNotifierProvider<SaveRoadmapNotifier, bool> {
  SaveRoadmapNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'saveRoadmapProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$saveRoadmapNotifierHash();

  @$internal
  @override
  SaveRoadmapNotifier create() => SaveRoadmapNotifier();
}

String _$saveRoadmapNotifierHash() =>
    r'8440ade99153ff56b45347d0419f33abd1bf7213';

abstract class _$SaveRoadmapNotifier extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, bool>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
