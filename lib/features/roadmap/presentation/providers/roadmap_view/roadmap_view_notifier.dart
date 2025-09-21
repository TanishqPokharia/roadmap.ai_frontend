import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/common/entities/roadmap.dart';
import 'package:roadmap_ai/features/roadmap/domain/usecases/get_roadmap_by_id/get_roadmap_by_id.dart';

part 'roadmap_view_notifier.g.dart';

class RoadmapViewState {
  final Roadmap roadmap;
  final String? error;
  final bool isLoading;

  RoadmapViewState({required this.roadmap, this.error, this.isLoading = false});
}

@riverpod
class RoadmapViewNotifier extends _$RoadmapViewNotifier {
  late final Roadmap _roadmap;
  @override
  FutureOr<RoadmapViewState> build(String roadmapId) async {
    final roadmap = await ref
        .read(getRoadmapByIdProvider)
        .call(GetRoadmapByIdParams(roadmapId: roadmapId))
        .run();

    return roadmap.fold(
      (failure) => throw Exception('Failed to load roadmap'),
      (roadmap) {
        _roadmap = roadmap;
        return RoadmapViewState(roadmap: roadmap);
      },
    );
  }

  void updateSubgoalStatus({
    required String goalId,
    required String subgoalId,
    required bool isCompleted,
  }) async {
    state = const AsyncLoading();
    final updatedRoadmap = _roadmap.copyWith(
      goals: _roadmap.goals.map((goal) {
        if (goal.id == goalId) {
          return goal.copyWith(
            subgoals: goal.subgoals.map((subgoal) {
              if (subgoal.id == subgoalId) {
                return subgoal.copyWith(
                  status: subgoal.status?.copyWith(isCompleted: isCompleted),
                );
              }
              return subgoal;
            }).toList(),
          );
        }
        return goal;
      }).toList(),
    );
    state = AsyncData(RoadmapViewState(roadmap: updatedRoadmap));
    _roadmap = updatedRoadmap;
  }
}
