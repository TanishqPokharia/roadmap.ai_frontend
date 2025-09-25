import 'package:fpdart/fpdart.dart';
import 'package:roadmap_ai/features/community/data/models/individualPost/individualPosts.dart';
import 'package:roadmap_ai/features/community/data/models/popularPosts/popularPosts.dart';

import '../../../../../core/utils/failures.dart';

abstract class CommunityRepository {
  TaskEither<Failure, PopularPostResponse> getPopularPost({
    required int limit,
    required int skip,
  });

  TaskEither<Failure, IndividualPostResponse> getIndividualPost({
    required String postId,
  });

}
