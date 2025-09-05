import 'package:fpdart/fpdart.dart';
import 'package:roadmap_ai/core/common/models/roadmap/roadmap.dart';
import 'package:roadmap_ai/core/utils/failures.dart';

abstract class RoadmapDatasource {
  TaskEither<Failure, RoadmapModel> getGeneratedRoadmap(String description);
}
