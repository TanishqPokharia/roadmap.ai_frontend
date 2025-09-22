import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:roadmap_ai/core/common/models/roadmap/roadmap.dart';
import 'package:roadmap_ai/core/utils/failures.dart';
import 'package:roadmap_ai/features/community/data/models/post_metadata/post_metadata.dart';
import 'package:roadmap_ai/features/community/data/models/user_post_stats/user_post_stats.dart';

abstract class PostDatasource {
  TaskEither<Failure, void> createPost({
    required RoadmapModel roadmap,
    required MultipartFile bannerImage,
  });

  TaskEither<Failure, List<PostMetadataModel>> getUserPostsMetaData({
    int limit = 10,
    int skip = 0,
  });

  TaskEither<Failure, UserPostStatsModel> getUserPostStats();
}
