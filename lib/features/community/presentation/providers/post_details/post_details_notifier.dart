import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/features/community/domain/entities/post_details.dart';
import 'package:roadmap_ai/features/community/domain/usecases/get_post_details/get_post_details.dart';
import 'package:roadmap_ai/features/roadmap/domain/usecases/save_post_roadmap/save_post_roadmap.dart';
import 'package:roadmap_ai/features/roadmap/presentation/providers/saved_roadmaps/saved_roadmaps_notifier.dart';

part 'post_details_notifier.g.dart';

Duration? _disableRetry(int retryCount, Object error) => null;

class PostDetailsState {
  final PostDetails postDetails;
  final String? error;

  PostDetailsState({required this.postDetails, required this.error});
}

@Riverpod(retry: _disableRetry)
class PostDetailsNotifier extends _$PostDetailsNotifier {
  @override
  FutureOr<PostDetailsState> build(String postId) async {
    final postDetails = await ref
        .read(getPostDetailsProvider)
        .call(GetPostDetailsParams(postId: postId))
        .run();
    await Future.delayed(Duration(milliseconds: 200));
    return postDetails.fold(
      (failure) => throw failure,
      (details) => PostDetailsState(error: null, postDetails: details),
    );
  }

  void savePostRoadmap(String postId) async {
    if (state is AsyncData<PostDetailsState>) {
      final post = state.value!.postDetails.post;
      state = AsyncData(
        PostDetailsState(
          error: null,
          postDetails: PostDetails(isSaved: true, post: post),
        ),
      );
      final result = await ref
          .read(savePostRoadmapProvider)
          .call(SavePostRoadmapParams(roadmap: post.roadmap, postId: postId))
          .run();
      result.fold(
        (failure) {
          state = AsyncData(
            PostDetailsState(
              error: failure.message,
              postDetails: PostDetails(isSaved: false, post: post),
            ),
          );
        },
        (_) {
          ref.invalidate(savedRoadmapsProvider);
        },
      );
    }
  }
}
