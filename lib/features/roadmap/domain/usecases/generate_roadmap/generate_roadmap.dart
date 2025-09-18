import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/common/entities/roadmap.dart';
import 'package:roadmap_ai/features/roadmap/data/repository/roadmap_repository_impl.dart';
import 'package:roadmap_ai/features/roadmap/domain/repository/roadmap_repository.dart';
import 'package:roadmap_ai/core/utils/failures.dart';
import 'package:roadmap_ai/core/utils/usecase.dart';

part 'generate_roadmap.g.dart';

@Riverpod(keepAlive: true)
GenerateRoadmap generateRoadmap(Ref ref) {
  final repository = ref.read(roadmapRepositoryProvider);
  final usecase = GenerateRoadmap(repository);
  return usecase;
}

class GenerateRoadmap implements Usecase<GenerateRoadmapParams, Roadmap> {
  final RoadmapRepository repository;
  GenerateRoadmap(this.repository);
  @override
  TaskEither<Failure, Roadmap> call(GenerateRoadmapParams params) {
    return repository.getGeneratedRoadmap(params.description);
  }
}

class GenerateRoadmapParams {
  final String description;
  GenerateRoadmapParams({required this.description});
}
