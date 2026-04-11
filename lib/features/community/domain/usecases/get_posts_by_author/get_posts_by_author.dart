import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/utils/failures.dart';
import 'package:roadmap_ai/core/utils/usecase.dart';
import 'package:roadmap_ai/features/community/data/repository/post_repository_impl.dart';
import 'package:roadmap_ai/features/community/domain/entities/post_metadata.dart';
import 'package:roadmap_ai/features/community/domain/repository/post_repository.dart';

part 'get_posts_by_author.g.dart';

@riverpod
GetPostsByAuthor getPostsByAuthor(Ref ref) {
  final repository = ref.read(postRepositoryProvider);
  return GetPostsByAuthor(repository);
}

class GetPostsByAuthor
    implements Usecase<GetPostsByAuthorParams, List<PostMetadata>> {
  final PostRepository _repository;

  GetPostsByAuthor(this._repository);
  @override
  TaskEither<Failure, List<PostMetadata>> call(GetPostsByAuthorParams params) {
    return _repository.getPostsByAuthor(
      limit: params.limit,
      skip: params.skip,
      authorId: params.authorId,
    );
  }
}

class GetPostsByAuthorParams {
  final int limit;
  final int skip;
  final String authorId;

  GetPostsByAuthorParams({
    required this.limit,
    required this.skip,
    required this.authorId,
  });
}
