import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/utils/failures.dart';
import 'package:roadmap_ai/core/utils/usecase.dart';
import 'package:roadmap_ai/features/community/data/repository/community_repository_impl.dart';

import '../../../data/models/popularPosts/popularPosts.dart';
import '../../repository/community_repository.dart';

part 'get_popular_posts.g.dart';

@Riverpod(keepAlive: true)
GetPopularPosts getPopularPosts(Ref ref) {
  final repository = ref.read(communityRepositoryProvider);
  return GetPopularPosts(repository);
}

class GetPopularPosts implements Usecase<GetPopularPostParams, PopularPostResponse> {
  final CommunityRepository _repository;

  GetPopularPosts(this._repository);
  @override
  TaskEither<Failure, PopularPostResponse> call(GetPopularPostParams params) {
    return _repository.getPopularPost(limit: params.limit ?? 10, skip: params.skip ?? 0);
  }
}

class GetPopularPostParams {
  final int? limit;
  final int? skip;

  GetPopularPostParams({required this.limit,required this.skip});
}
