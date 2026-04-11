// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roadmap_view_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RoadmapViewNotifier)
final roadmapViewProvider = RoadmapViewNotifierFamily._();

final class RoadmapViewNotifierProvider
    extends $AsyncNotifierProvider<RoadmapViewNotifier, RoadmapViewState> {
  RoadmapViewNotifierProvider._({
    required RoadmapViewNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'roadmapViewProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$roadmapViewNotifierHash();

  @override
  String toString() {
    return r'roadmapViewProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  RoadmapViewNotifier create() => RoadmapViewNotifier();

  @override
  bool operator ==(Object other) {
    return other is RoadmapViewNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$roadmapViewNotifierHash() =>
    r'e01c4677d573e7a36f684ae7f86afd1384d69b17';

final class RoadmapViewNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          RoadmapViewNotifier,
          AsyncValue<RoadmapViewState>,
          RoadmapViewState,
          FutureOr<RoadmapViewState>,
          String
        > {
  RoadmapViewNotifierFamily._()
    : super(
        retry: null,
        name: r'roadmapViewProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RoadmapViewNotifierProvider call(String roadmapId) =>
      RoadmapViewNotifierProvider._(argument: roadmapId, from: this);

  @override
  String toString() => r'roadmapViewProvider';
}

abstract class _$RoadmapViewNotifier extends $AsyncNotifier<RoadmapViewState> {
  late final _$args = ref.$arg as String;
  String get roadmapId => _$args;

  FutureOr<RoadmapViewState> build(String roadmapId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<RoadmapViewState>, RoadmapViewState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<RoadmapViewState>, RoadmapViewState>,
              AsyncValue<RoadmapViewState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
