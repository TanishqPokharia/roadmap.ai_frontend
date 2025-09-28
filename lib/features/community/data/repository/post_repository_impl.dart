import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:roadmap_ai/core/common/entities/roadmap.dart';
import 'package:roadmap_ai/core/common/models/roadmap/roadmap.dart';
import 'package:roadmap_ai/core/utils/failures.dart';
import 'package:roadmap_ai/features/community/data/datasource/impl/post_datasource_impl.dart';
import 'package:roadmap_ai/features/community/data/datasource/interface/post_datasource.dart';
import 'package:roadmap_ai/features/community/data/models/post_details/post_details.dart';
import 'package:roadmap_ai/features/community/data/models/post_metadata/post_metadata.dart';
import 'package:roadmap_ai/features/community/data/models/user_post_stats/user_post_stats.dart';
import 'package:roadmap_ai/features/community/domain/entities/post_details.dart';
import 'package:roadmap_ai/features/community/domain/entities/post_metadata.dart';
import 'package:roadmap_ai/features/community/domain/entities/user_post_stats.dart';
import 'package:roadmap_ai/features/community/domain/repository/post_repository.dart';

part 'post_repository_impl.g.dart';

@riverpod
PostRepository postRepository(Ref ref) {
  final datasource = ref.read(postDatasourceProvider);
  return PostRepositoryImpl(datasource);
}

class PostRepositoryImpl implements PostRepository {
  final PostDatasource _datasource;

  PostRepositoryImpl(this._datasource);
  @override
  TaskEither<Failure, void> createPost({
    required Roadmap roadmap,
    required MultipartFile bannerImage,
  }) {
    return _datasource.createPost(
      roadmap: RoadmapModel.fromEntity(roadmap),
      bannerImage: bannerImage,
    );
  }

  @override
  TaskEither<Failure, List<PostMetadata>> getUserPostsMetaData({
    int limit = 10,
    int skip = 0,
  }) {
    return _datasource
        .getUserPostsMetaData(limit: limit, skip: skip)
        .map((models) => models.map((model) => model.toEntity()).toList());
  }

  @override
  TaskEither<Failure, UserPostStats> getUserPostStats() {
    return _datasource.getUserPostStats().map((model) => model.toEntity());
  }

  @override
  TaskEither<Failure, PostDetails> getPostDetails({required String postId}) {
    return _datasource
        .getPostDetails(postId: postId)
        .map((model) => model.toEntity());
  }

  @override
  TaskEither<Failure, List<PostMetadata>> getPopularPosts({
    int limit = 10,
    int skip = 0,
  }) {
    return _datasource
        .getPopularPosts(limit: limit, skip: skip)
        .map((models) => models.map((model) => model.toEntity()).toList());
  }

  @override
  TaskEither<Failure, List<PostMetadata>> getPostsByTime({
    int limit = 10,
    int skip = 0,
    required PostTime postTime,
  }) {
    return _datasource
        .getPostsByTime(limit: limit, skip: skip, postTime: postTime)
        .map((models) => models.map((model) => model.toEntity()).toList());
  }

  @override
  TaskEither<Failure, List<PostMetadata>> getPostsByTitle({
    int limit = 10,
    int skip = 0,
    required String title,
  }) {
    return _datasource
        .getPostsByTitle(limit: limit, skip: skip, title: title)
        .map((models) => models.map((model) => model.toEntity()).toList());
  }
}
