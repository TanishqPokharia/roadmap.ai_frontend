import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/common/entities/roadmap.dart';
import 'package:roadmap_ai/core/utils/failures.dart';
import 'package:roadmap_ai/core/utils/usecase.dart';
import 'package:roadmap_ai/features/roadmap/data/repository/roadmap_repository_impl.dart';
import 'package:roadmap_ai/features/roadmap/domain/repository/roadmap_repository.dart';

part 'save_post_roadmap.g.dart';

@riverpod
SavePostRoadmap savePostRoadmap(Ref ref) {
  final repository = ref.read(roadmapRepositoryProvider);
  return SavePostRoadmap(repository);
}

class SavePostRoadmap implements Usecase<SavePostRoadmapParams, void> {
  final RoadmapRepository _repository;

  SavePostRoadmap(this._repository);
  @override
  TaskEither<Failure, void> call(SavePostRoadmapParams params) {
    return _repository.savePostRoadmap(params.roadmap, params.postId);
  }
}

class SavePostRoadmapParams {
  final Roadmap roadmap;
  final String postId;

  SavePostRoadmapParams({required this.roadmap, required this.postId});
}
