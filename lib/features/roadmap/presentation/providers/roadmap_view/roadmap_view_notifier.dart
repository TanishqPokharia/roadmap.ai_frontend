import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/common/entities/roadmap.dart';
import 'package:roadmap_ai/core/common/entities/goal.dart';
import 'package:roadmap_ai/core/common/entities/subgoal.dart';
import 'package:roadmap_ai/features/roadmap/domain/usecases/get_roadmap_by_id/get_roadmap_by_id.dart';
import 'package:roadmap_ai/features/roadmap/domain/usecases/update_roadmap_subgoal_status/update_roadmap_subgoal_status.dart';
import 'package:roadmap_ai/features/roadmap/presentation/providers/saved_roadmaps/saved_roadmaps_notifier.dart';

part 'roadmap_view_notifier.g.dart';

class RoadmapViewState {
  final Roadmap roadmap;
  final String? error;
  final bool isLoading;

  RoadmapViewState({required this.roadmap, this.error, this.isLoading = false});
}

@riverpod
class RoadmapViewNotifier extends _$RoadmapViewNotifier {
  late Roadmap _roadmap;
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

  Future<void> updateSubgoalStatus({
    required String goalId,
    required String subgoalId,
    required int goalIndex,
    required int subgoalIndex,
    required bool isCompleted,
  }) async {
    // Store only the original subgoal for efficient rollback
    final originalSubgoal = _roadmap.goals[goalIndex].subgoals[subgoalIndex];

    // Create updated subgoal
    final updatedSubgoal = originalSubgoal.copyWith(
      status: originalSubgoal.status?.copyWith(completed: isCompleted),
    );

    // Efficiently update only the specific subgoal using direct index access
    final updatedSubgoals = List<Subgoal>.from(
      _roadmap.goals[goalIndex].subgoals,
    );
    updatedSubgoals[subgoalIndex] = updatedSubgoal;

    final updatedGoal = _roadmap.goals[goalIndex].copyWith(
      subgoals: updatedSubgoals,
    );

    final updatedGoals = List<Goal>.from(_roadmap.goals);
    updatedGoals[goalIndex] = updatedGoal;

    final updatedRoadmap = _roadmap.copyWith(goals: updatedGoals);

    // Update state immediately for responsive UI
    _roadmap = updatedRoadmap;
    state = AsyncData(RoadmapViewState(roadmap: updatedRoadmap));

    // Call the update usecase asynchronously
    final result = await ref
        .read(updateRoadmapSubgoalStatusProvider)
        .call(
          UpdateRoadmapSubgoalStatusParams(
            goalId: goalId,
            subgoalId: subgoalId,
            roadmapId: _roadmap.id,
            isCompleted: isCompleted,
          ),
        )
        .run();

    result.fold(
      (failure) {
        // On failure, efficiently revert only the changed subgoal
        final revertedSubgoals = List<Subgoal>.from(
          _roadmap.goals[goalIndex].subgoals,
        );
        revertedSubgoals[subgoalIndex] = originalSubgoal;

        final revertedGoal = _roadmap.goals[goalIndex].copyWith(
          subgoals: revertedSubgoals,
        );
        final revertedGoals = List<Goal>.from(_roadmap.goals);
        revertedGoals[goalIndex] = revertedGoal;

        final revertedRoadmap = _roadmap.copyWith(goals: revertedGoals);

        state = AsyncData(
          RoadmapViewState(roadmap: revertedRoadmap, error: failure.message),
        );
        _roadmap = revertedRoadmap;
      },
      (_) {
        // Success - state already updated optimistically
        // call the saved roadmap notifier to update progress locally

        final completedSubgoals = _roadmap.goals
            .flatMap(
              (goal) => goal.subgoals.where(
                (subgoal) => subgoal.status?.completed == true,
              ),
            )
            .length;

        final totalSubgoals = _roadmap.goals.fold<int>(
          0,
          (previousValue, goal) => previousValue + goal.subgoals.length,
        );
        ref
            .read(savedRoadmapsNotifierProvider.notifier)
            .updateRoadmapProgress(
              _roadmap.id,
              completedSubgoals,
              totalSubgoals,
            );
      },
    );
  }
}
