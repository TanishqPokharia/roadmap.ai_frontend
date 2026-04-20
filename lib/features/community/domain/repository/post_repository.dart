import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:roadmap_ai/core/common/entities/roadmap.dart';
import 'package:roadmap_ai/core/utils/failures.dart';
import 'package:roadmap_ai/core/utils/post_filters.dart';
import 'package:roadmap_ai/features/community/data/datasource/interface/post_datasource.dart';
import 'package:roadmap_ai/features/community/domain/entities/post_details.dart';
import 'package:roadmap_ai/features/community/domain/entities/post_metadata.dart';
import 'package:roadmap_ai/features/community/domain/entities/user_post_stats.dart';

abstract class PostRepository {
  TaskEither<Failure, void> createPost({
    required Roadmap roadmap,
    required MultipartFile bannerImage,
    List<PostGenreFilter>? genre,
  });
  TaskEither<Failure, List<PostMetadata>> getUserPostsMetaData({
    int limit = 10,
    int skip = 0,
  });
  TaskEither<Failure, UserPostStats> getUserPostStats();
  TaskEither<Failure, PostDetails> getPostDetails({required String postId});
  TaskEither<Failure, List<PostMetadata>> getPopularPosts({
    int limit = 10,
    int skip = 0,
    List<PostGenreFilter>? genre,
  });
  TaskEither<Failure, List<PostMetadata>> getPostsByTime({
    int limit = 10,
    int skip = 0,
    required PostTime postTime,
    List<PostGenreFilter>? genre,
  });
  TaskEither<Failure, List<PostMetadata>> getPostsByTitle({
    int limit = 10,
    int skip = 0,
    required String title,
  });
  TaskEither<Failure, List<PostMetadata>> getPostsByAuthor({
    int limit = 10,
    int skip = 0,
    required String authorId,
  });
  TaskEither<Failure, void> togglePostLike({required String postId});
}
