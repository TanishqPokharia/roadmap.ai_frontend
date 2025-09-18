import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/common/entities/roadmap.dart';
import 'package:roadmap_ai/core/utils/failures.dart';
import 'package:roadmap_ai/core/utils/usecase.dart';
import 'package:roadmap_ai/features/roadmap/data/repository/roadmap_repository_impl.dart';
import 'package:roadmap_ai/features/roadmap/domain/repository/roadmap_repository.dart';

part 'get_roadmap_by_id.g.dart';

@riverpod
GetRoadmapById getRoadmapById(Ref ref) {
  final repository = ref.read(roadmapRepositoryProvider);
  return GetRoadmapById(repository);
}

class GetRoadmapById implements Usecase<GetRoadmapByIdParams, Roadmap> {
  final RoadmapRepository _repository;

  GetRoadmapById(this._repository);
  @override
  TaskEither<Failure, Roadmap> call(GetRoadmapByIdParams params) {
    return _repository.getRoadmapById(params.roadmapId);
  }
}

class GetRoadmapByIdParams {
  final String roadmapId;

  GetRoadmapByIdParams({required this.roadmapId});
}
