// ignore: implementation_imports
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/utils/failures.dart';
import 'package:roadmap_ai/features/community/data/datasource/interface/community_datasource.dart';
import 'package:roadmap_ai/features/community/data/models/individualPost/individualPosts.dart';
import 'package:roadmap_ai/features/community/data/models/popularPosts/popularPosts.dart';

import '../../domain/repository/community_repository.dart';
import '../datasource/impl/community_datasource_impl.dart';
part 'community_repository_impl.g.dart';

@riverpod
CommunityRepository communityRepository(Ref ref) {
  final datasource = ref.watch(communityDatasourceProvider);
  return CommunityRepositoryImpl(datasource);
}

class CommunityRepositoryImpl implements CommunityRepository {
  final CommunityDatasource _datasource;

  CommunityRepositoryImpl(this._datasource);

  @override
  TaskEither<Failure, IndividualPostResponse> getIndividualPost({required String postId}) {
    final result = _datasource.getIndividualPost(postId: postId);
    return result.map(
          (individualPostModel) => IndividualPostResponse(
            roadmap: individualPostModel.roadmap,
      ),
    );
  }

  @override
  TaskEither<Failure, PopularPostResponse> getPopularPost({required int limit, required int skip}) {
    final result = _datasource.getPopularPost(limit: limit, skip: skip);
        return result.map(
        (popularPostModel) => PopularPostResponse(
   posts: popularPostModel.posts,
    ),
    );
  }

}
