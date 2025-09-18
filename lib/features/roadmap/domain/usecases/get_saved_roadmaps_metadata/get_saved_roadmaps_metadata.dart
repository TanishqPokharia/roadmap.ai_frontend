import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/common/entities/roadmap_metadata.dart';
import 'package:roadmap_ai/core/utils/failures.dart';
import 'package:roadmap_ai/core/utils/usecase.dart';
import 'package:roadmap_ai/features/roadmap/data/repository/roadmap_repository_impl.dart';
import 'package:roadmap_ai/features/roadmap/domain/repository/roadmap_repository.dart';

part 'get_saved_roadmaps_metadata.g.dart';

@Riverpod(keepAlive: true)
GetSavedRoadmapsMetadata getSavedRoadmapsMetadata(Ref ref) {
  return GetSavedRoadmapsMetadata(ref.read(roadmapRepositoryProvider));
}

class GetSavedRoadmapsMetadata
    implements Usecase<GetSavedRoadmapsMetadataParams, List<RoadmapMetadata>> {
  final RoadmapRepository _repository;

  GetSavedRoadmapsMetadata(this._repository);
  @override
  TaskEither<Failure, List<RoadmapMetadata>> call(
    GetSavedRoadmapsMetadataParams params,
  ) {
    return _repository.getSavedRoadmaps(params.limit, params.skip);
  }
}

class GetSavedRoadmapsMetadataParams {
  final int limit;
  final int skip;

  GetSavedRoadmapsMetadataParams({required this.limit, required this.skip});
}
