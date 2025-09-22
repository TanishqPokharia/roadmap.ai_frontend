import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:roadmap_ai/core/common/models/roadmap/roadmap.dart';
import 'package:roadmap_ai/core/utils/failures.dart';

abstract class PostDatasource {
  TaskEither<Failure, void> createPost({
    required RoadmapModel roadmap,
    required MultipartFile bannerImage,
  });
}
