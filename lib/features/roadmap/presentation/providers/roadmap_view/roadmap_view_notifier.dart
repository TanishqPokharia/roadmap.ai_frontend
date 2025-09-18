import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/common/entities/roadmap.dart';
import 'package:roadmap_ai/features/roadmap/domain/usecases/get_roadmap_by_id/get_roadmap_by_id.dart';

part 'roadmap_view_notifier.g.dart';

@riverpod
class RoadmapViewNotifier extends _$RoadmapViewNotifier {
  @override
  FutureOr<Roadmap> build(String roadmapId) async {
    final roadmap = await ref
        .read(getRoadmapByIdProvider)
        .call(GetRoadmapByIdParams(roadmapId: roadmapId))
        .run();

    return roadmap.fold(
      (failure) => throw Exception('Failed to load roadmap'),
      (roadmap) => roadmap,
    );
  }
}
