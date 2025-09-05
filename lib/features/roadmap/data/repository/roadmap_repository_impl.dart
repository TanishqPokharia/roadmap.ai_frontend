import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/common/entities/roadmap.dart';
import 'package:roadmap_ai/core/common/models/roadmap/roadmap.dart';
import 'package:roadmap_ai/features/roadmap/data/datasource/impl/roadmap_datasource_impl.dart';
import 'package:roadmap_ai/features/roadmap/data/datasource/interface/roadmap_datasource.dart';
import 'package:roadmap_ai/features/roadmap/domain/repository/roadmap_repository.dart';
import 'package:roadmap_ai/core/utils/failures.dart';

part 'roadmap_repository_impl.g.dart';

@riverpod
RoadmapRepository roadmapRepository(Ref ref) {
  return RoadmapRepositoryImpl(ref.read(roadmapDatasourceProvider));
}

class RoadmapRepositoryImpl implements RoadmapRepository {
  final RoadmapDatasource _datasource;
  RoadmapRepositoryImpl(this._datasource);
  @override
  TaskEither<Failure, Roadmap> getGeneratedRoadmap(String description) {
    return _datasource
        .getGeneratedRoadmap(description)
        .map((roadmapModel) => roadmapModel.toEntity());
  }
}
