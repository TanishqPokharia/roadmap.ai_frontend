import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/common/entities/roadmap.dart';
import 'package:roadmap_ai/features/roadmap/domain/usecases/generate_roadmap/generate_roadmap.dart';

part 'roadmap_notifier.g.dart';

@riverpod
class RoadmapNotifier extends _$RoadmapNotifier {
  @override
  FutureOr<Roadmap?> build() async {
    return null;
  }

  Future<void> getRoadmap(String description) async {
    state = const AsyncLoading();
    final roadmap = await ref
        .read(generateRoadmapProvider)
        .call(GenerateRoadmapParams(description: description))
        .run();
    roadmap.fold(
      (failure) {
        state = AsyncError(failure, StackTrace.current);
      },
      (r) {
        state = AsyncData(r);
      },
    );
  }

  Future<void> resetRoadmap() async {
    state = const AsyncData(null);
  }
}
