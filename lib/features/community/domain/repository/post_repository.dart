import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:roadmap_ai/core/common/entities/roadmap.dart';
import 'package:roadmap_ai/core/utils/failures.dart';
import 'package:roadmap_ai/features/community/domain/entities/post_metadata.dart';
import 'package:roadmap_ai/features/community/domain/entities/user_post_stats.dart';

abstract class PostRepository {
  TaskEither<Failure, void> createPost({
    required Roadmap roadmap,
    required MultipartFile bannerImage,
  });
  TaskEither<Failure, List<PostMetadata>> getUserPostsMetaData({
    int limit = 10,
    int skip = 0,
  });
  TaskEither<Failure, UserPostStats> getUserPostStats();
}
