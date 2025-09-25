import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/utils/failures.dart';
import 'package:roadmap_ai/core/utils/no_params.dart';
import 'package:roadmap_ai/core/utils/usecase.dart';
import 'package:roadmap_ai/features/auth/data/repository/auth_repository_impl.dart';
import 'package:roadmap_ai/features/auth/domain/entities/user_details.dart';
import 'package:roadmap_ai/features/auth/domain/repository/auth_repository.dart';
import 'package:roadmap_ai/features/community/data/models/individualPost/individualPosts.dart';
import 'package:roadmap_ai/features/community/data/repository/community_repository_impl.dart';

import '../../repository/community_repository.dart';

part 'get_individual_posts.g.dart';

@Riverpod(keepAlive: true)
GetIndividualPosts getIndividualPosts(Ref ref) {
  final repository = ref.read(communityRepositoryProvider);
  return GetIndividualPosts(repository);
}

class GetIndividualPosts implements Usecase<IndividualPostParams, IndividualPostResponse> {
  final CommunityRepository _repository;

  GetIndividualPosts(this._repository);
  @override
  TaskEither<Failure, IndividualPostResponse> call(IndividualPostParams params) {
    return _repository.getIndividualPost(postId: params.postId);
  }
}

class IndividualPostParams {
  final String postId;

  IndividualPostParams({required this.postId});
}
