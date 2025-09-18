import 'package:fpdart/fpdart.dart';
import 'package:roadmap_ai/core/common/entities/roadmap.dart';
import 'package:roadmap_ai/core/common/entities/roadmap_metadata.dart';
import 'package:roadmap_ai/core/utils/failures.dart';

abstract class RoadmapRepository {
  TaskEither<Failure, Roadmap> getGeneratedRoadmap(String description);
  TaskEither<Failure, void> saveRoadmap(Roadmap roadmap);
  TaskEither<Failure, List<RoadmapMetadata>> getSavedRoadmaps(
    int limit,
    int skip,
  );
  TaskEither<Failure, Roadmap> getRoadmapById(String roadmapId);
}
