import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/features/community/domain/entities/post_details.dart';
import 'package:roadmap_ai/features/community/domain/usecases/get_post_details/get_post_details.dart';

part 'post_details_notifier.g.dart';

@riverpod
class PostDetailsNotifier extends _$PostDetailsNotifier {
  @override
  FutureOr<PostDetails> build(String postId) async {
    final postDetails = await ref
        .read(getPostDetailsProvider)
        .call(GetPostDetailsParams(postId: postId))
        .run();
    return postDetails.fold((failure) => throw failure, (details) => details);
  }

  void toggleLike(bool isLiked) {}
  void saveRoadmap() {}
}
