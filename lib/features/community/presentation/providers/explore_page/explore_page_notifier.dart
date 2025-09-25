import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/models/popularPosts/popularPosts.dart'
    show PopularPostResponse, Post;
import '../../../domain/entities/popularPost.dart' as domain;
import '../../../domain/usecases/popularPost/get_popular_posts.dart';

part 'explore_page_notifier.g.dart';

class PopularPostState {
  final domain.PopularPostResponse popularPostResponse;
  final String? error;
  final bool isLoading;

  PopularPostState({
    required this.popularPostResponse,
    this.error,
    this.isLoading = false,
  });
}



@riverpod
class ExplorePageNotifier extends _$ExplorePageNotifier {
  @override
  FutureOr<PopularPostState> build({
    required int limit,
    required int skip,
  }) async {
    final popularPostEither = await ref
        .read(getPopularPostsProvider)
        .call(GetPopularPostParams(limit: limit, skip: skip))
        .run();

    return popularPostEither.fold(
          (failure) => throw Exception('Failed to load popular posts: ${failure.message}'),
          (response) {
        final domainResponse = domain.PopularPostResponse(
          posts: response.posts.map((p) {
            return domain.Post(
              likes: p.likes,
              bannerImage: p.bannerImage,
              views: p.views,
              createdAt: p.createdAt,
              v: p.v,
              id: p.id,
              title: p.title,
              description: p.description,
            );
          }).toList(),
        );

        return PopularPostState(popularPostResponse: domainResponse);
      },
    );
  }
}
