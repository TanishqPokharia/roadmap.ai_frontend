import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/utils/failures.dart';
import 'package:roadmap_ai/core/utils/usecase.dart';
import 'package:roadmap_ai/features/community/data/repository/post_repository_impl.dart';
import 'package:roadmap_ai/features/community/domain/entities/post_details.dart';
import 'package:roadmap_ai/features/community/domain/repository/post_repository.dart';

part 'get_post_details.g.dart';

@riverpod
GetPostDetails getPostDetails(Ref ref) {
  final repository = ref.read(postRepositoryProvider);
  return GetPostDetails(repository);
}

class GetPostDetails implements Usecase<GetPostDetailsParams, PostDetails> {
  final PostRepository _repository;

  GetPostDetails(this._repository);
  @override
  TaskEither<Failure, PostDetails> call(GetPostDetailsParams params) {
    return _repository.getPostDetails(postId: params.postId);
  }
}

class GetPostDetailsParams {
  final String postId;

  GetPostDetailsParams({required this.postId});
}
