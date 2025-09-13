import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/common/entities/roadmap.dart';
import 'package:roadmap_ai/core/utils/failures.dart';
import 'package:roadmap_ai/core/utils/usecase.dart';
import 'package:roadmap_ai/features/roadmap/data/repository/roadmap_repository_impl.dart';
import 'package:roadmap_ai/features/roadmap/domain/repository/roadmap_repository.dart';

part 'save_roadmap.g.dart';

@riverpod
SaveRoadmap saveRoadmap(Ref ref) {
  final repository = ref.read(roadmapRepositoryProvider);
  return SaveRoadmap(repository);
}

class SaveRoadmap implements Usecase<SaveRoadmapParams, void> {
  final RoadmapRepository _repository;

  SaveRoadmap(this._repository);
  @override
  TaskEither<Failure, void> call(SaveRoadmapParams params) {
    return _repository.saveRoadmap(params.roadmap);
  }
}

class SaveRoadmapParams {
  final Roadmap roadmap;

  SaveRoadmapParams({required this.roadmap});
}
