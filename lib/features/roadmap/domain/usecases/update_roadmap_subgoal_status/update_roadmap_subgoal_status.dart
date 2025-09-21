import 'package:fpdart/fpdart.dart';
import 'package:roadmap_ai/core/utils/failures.dart';
import 'package:roadmap_ai/core/utils/usecase.dart';
import 'package:roadmap_ai/features/roadmap/domain/repository/roadmap_repository.dart';

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
