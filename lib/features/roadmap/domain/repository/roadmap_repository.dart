import 'package:fpdart/fpdart.dart';
import 'package:roadmap_ai/core/common/entities/roadmap.dart';
import 'package:roadmap_ai/core/utils/failures.dart';

abstract class RoadmapRepository {
  TaskEither<Failure, Roadmap> getGeneratedRoadmap(String description);
}
