import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/utils/failures.dart';
import 'package:roadmap_ai/core/utils/usecase.dart';
import 'package:roadmap_ai/features/community/data/repository/post_repository_impl.dart';
import 'package:roadmap_ai/features/community/domain/entities/post_metadata.dart';
import 'package:roadmap_ai/features/community/domain/repository/post_repository.dart';

part 'get_user_posts_metadata.g.dart';

@riverpod
GetUserPostsMetadata getUserPostsMetaData(Ref ref) {
  final repository = ref.read(postRepositoryProvider);
  return GetUserPostsMetadata(repository);
}

class GetUserPostsMetadata
    implements Usecase<GetUserPostsMetadataParams, List<PostMetadata>> {
  final PostRepository _repository;

  GetUserPostsMetadata(this._repository);
  @override
  TaskEither<Failure, List<PostMetadata>> call(
    GetUserPostsMetadataParams params,
  ) {
    return _repository.getUserPostsMetaData(
      limit: params.limit,
      skip: params.skip,
    );
  }
}

class GetUserPostsMetadataParams {
  final int limit;
  final int skip;

  GetUserPostsMetadataParams({required this.limit, required this.skip});
}
