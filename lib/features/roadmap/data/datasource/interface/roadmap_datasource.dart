import 'package:fpdart/fpdart.dart';
import 'package:roadmap_ai/core/common/models/roadmap/roadmap.dart';
import 'package:roadmap_ai/core/common/models/roadmap_metadata/roadmap_metadata.dart';
import 'package:roadmap_ai/core/utils/failures.dart';

abstract class RoadmapDatasource {
  TaskEither<Failure, RoadmapModel> getGeneratedRoadmap(String description);
  TaskEither<Failure, void> saveRoadmap(RoadmapModel roadmap);
  TaskEither<Failure, List<RoadmapMetadataModel>> getSavedRoadmaps(
    int limit,
    int skip,
  );
}
