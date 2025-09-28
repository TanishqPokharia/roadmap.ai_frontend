import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/utils/failures.dart';
import 'package:roadmap_ai/core/utils/usecase.dart';
import 'package:roadmap_ai/features/community/data/datasource/interface/post_datasource.dart';
import 'package:roadmap_ai/features/community/data/repository/post_repository_impl.dart';
import 'package:roadmap_ai/features/community/domain/entities/post_metadata.dart';
import 'package:roadmap_ai/features/community/domain/repository/post_repository.dart';

part 'get_filtered_posts.g.dart';

@riverpod
GetFilteredPosts getFilteredPosts(Ref ref) {
  final repository = ref.read(postRepositoryProvider);
  return GetFilteredPosts(repository);
}

/// The type of post fetched will depend on the [GetFilteredPostsParams] passed.
class GetFilteredPosts
    implements Usecase<GetFilteredPostsParams, List<PostMetadata>> {
  final PostRepository _repository;

  GetFilteredPosts(this._repository);
  @override
  TaskEither<Failure, List<PostMetadata>> call(GetFilteredPostsParams params) {
    return switch (params) {
      GetPostsByTimeParams(:final limit, :final skip, :final postTime) =>
        _repository.getPostsByTime(
          postTime: postTime,
          limit: limit,
          skip: skip,
        ),
      GetPopularPostsParams(:final limit, :final skip) =>
        _repository.getPopularPosts(limit: limit, skip: skip),
    };
  }
}

sealed class GetFilteredPostsParams {
  final int limit;
  final int skip;

  GetFilteredPostsParams({this.limit = 10, this.skip = 0});
}

class GetPostsByTimeParams extends GetFilteredPostsParams {
  final PostTime postTime;

  GetPostsByTimeParams({required this.postTime, int limit = 10, int skip = 0});
}

class GetPopularPostsParams extends GetFilteredPostsParams {
  GetPopularPostsParams({super.limit, super.skip});
}
