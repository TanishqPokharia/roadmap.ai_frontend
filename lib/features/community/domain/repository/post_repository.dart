import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:roadmap_ai/core/common/entities/roadmap.dart';
import 'package:roadmap_ai/core/utils/failures.dart';

abstract class PostRepository {
  TaskEither<Failure, void> createPost({
    required Roadmap roadmap,
    required MultipartFile bannerImage,
  });
}
