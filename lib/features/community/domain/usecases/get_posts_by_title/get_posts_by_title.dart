import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/src/task_either.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/utils/failures.dart';
import 'package:roadmap_ai/core/utils/usecase.dart';
import 'package:roadmap_ai/features/community/data/repository/post_repository_impl.dart';
import 'package:roadmap_ai/features/community/domain/entities/post_metadata.dart';
import 'package:roadmap_ai/features/community/domain/repository/post_repository.dart';

part 'get_posts_by_title.g.dart';

@riverpod
GetPostsByTitle getPostsByTitle(Ref ref) {
  final repository = ref.read(postRepositoryProvider);
  return GetPostsByTitle(repository);
}

class GetPostsByTitle
    implements Usecase<GetPostsByTitleParams, List<PostMetadata>> {
  final PostRepository _repository;

  GetPostsByTitle(this._repository);
  @override
  TaskEither<Failure, List<PostMetadata>> call(GetPostsByTitleParams params) {
    return _repository.getPostsByTitle(
      title: params.title,
      limit: params.limit,
      skip: params.skip,
    );
  }
}

class GetPostsByTitleParams {
  final String title;
  final int limit;
  final int skip;

  GetPostsByTitleParams({required this.title, this.limit = 10, this.skip = 0});
}
