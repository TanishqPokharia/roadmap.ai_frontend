import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/utils/failures.dart';
import 'package:roadmap_ai/core/utils/usecase.dart';
import 'package:roadmap_ai/features/community/data/repository/post_repository_impl.dart';
import 'package:roadmap_ai/features/community/domain/repository/post_repository.dart';

part 'toggle_post_like.g.dart';

@riverpod
TogglePostLike togglePostLike(Ref ref) {
  final repository = ref.read(postRepositoryProvider);
  return TogglePostLike(repository);
}

class TogglePostLike implements Usecase<TogglePostParams, void> {
  final PostRepository _repository;

  TogglePostLike(this._repository);
  @override
  TaskEither<Failure, void> call(TogglePostParams params) {
    return _repository.togglePostLike(postId: params.postId);
  }
}

class TogglePostParams {
  final String postId;

  TogglePostParams({required this.postId});
}
