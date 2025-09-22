import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/utils/failures.dart';
import 'package:roadmap_ai/core/utils/usecase.dart';
import 'package:roadmap_ai/features/roadmap/data/repository/roadmap_repository_impl.dart';
import 'package:roadmap_ai/features/roadmap/domain/repository/roadmap_repository.dart';

part 'update_roadmap_subgoal_status.g.dart';

@Riverpod(keepAlive: true)
UpdateRoadmapSubgoalStatus updateRoadmapSubgoalStatus(Ref ref) {
  final repository = ref.watch(roadmapRepositoryProvider);
  return UpdateRoadmapSubgoalStatus(repository);
}

class UpdateRoadmapSubgoalStatus
    implements Usecase<UpdateRoadmapSubgoalStatusParams, void> {
  final RoadmapRepository _repository;

  UpdateRoadmapSubgoalStatus(this._repository);
  @override
  TaskEither<Failure, void> call(UpdateRoadmapSubgoalStatusParams params) {
    return _repository.updateRoadmapSubgoalStatus(
      roadmapId: params.roadmapId,
      goalId: params.goalId,
      subgoalId: params.subgoalId,
      isCompleted: params.isCompleted,
    );
  }
}

class UpdateRoadmapSubgoalStatusParams {
  final String roadmapId;
  final String goalId;
  final String subgoalId;
  final bool isCompleted;

  UpdateRoadmapSubgoalStatusParams({
    required this.roadmapId,
    required this.goalId,
    required this.subgoalId,
    required this.isCompleted,
  });
}
