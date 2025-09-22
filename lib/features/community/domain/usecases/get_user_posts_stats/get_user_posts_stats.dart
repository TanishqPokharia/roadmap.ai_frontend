import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/utils/failures.dart';
import 'package:roadmap_ai/core/utils/no_params.dart';
import 'package:roadmap_ai/core/utils/usecase.dart';
import 'package:roadmap_ai/features/community/data/repository/post_repository_impl.dart';
import 'package:roadmap_ai/features/community/domain/entities/user_post_stats.dart';
import 'package:roadmap_ai/features/community/domain/repository/post_repository.dart';

part 'get_user_posts_stats.g.dart';

@riverpod
GetUserPostsStats getUserPostsStats(Ref ref) {
  final repository = ref.read(postRepositoryProvider);
  return GetUserPostsStats(repository);
}

class GetUserPostsStats implements Usecase<NoParams, UserPostStats> {
  final PostRepository _repository;

  GetUserPostsStats(this._repository);
  @override
  TaskEither<Failure, UserPostStats> call(NoParams params) {
    return _repository.getUserPostStats();
  }
}
