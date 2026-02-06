// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roadmap_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RoadmapNotifier)
final roadmapProvider = RoadmapNotifierProvider._();

final class RoadmapNotifierProvider
    extends $AsyncNotifierProvider<RoadmapNotifier, Roadmap?> {
  RoadmapNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'roadmapProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$roadmapNotifierHash();

  @$internal
  @override
  RoadmapNotifier create() => RoadmapNotifier();
}

String _$roadmapNotifierHash() => r'784cbc820cad2aebd5ea4ff772f6890747e8e696';

abstract class _$RoadmapNotifier extends $AsyncNotifier<Roadmap?> {
  FutureOr<Roadmap?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Roadmap?>, Roadmap?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Roadmap?>, Roadmap?>,
              AsyncValue<Roadmap?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
