import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/utils/failures.dart';
import 'package:roadmap_ai/core/utils/post_filters.dart';
import 'package:roadmap_ai/features/community/data/datasource/interface/post_datasource.dart';
import 'package:roadmap_ai/features/community/data/models/post_metadata/post_metadata.dart';
import 'package:roadmap_ai/features/community/domain/entities/post_metadata.dart';
import 'package:roadmap_ai/features/community/domain/usecases/get_filtered_posts/get_filtered_posts.dart';
import 'package:roadmap_ai/features/community/domain/usecases/get_posts_by_title/get_posts_by_title.dart';
import 'package:roadmap_ai/features/community/domain/usecases/toggle_post_like/toggle_post_like.dart';
import 'package:roadmap_ai/features/community/presentation/providers/post_title/post_title_notifier.dart';
import 'package:roadmap_ai/features/community/presentation/providers/posts_filter/posts_filter_notifier.dart';

part 'posts_notifier.g.dart';

class PostsState {
  final List<PostMetadata> posts;
  final bool hasMore;
  final String? error;

  PostsState({required this.posts, required this.hasMore, this.error});

  PostsState copyWith({
    List<PostMetadata>? posts,
    bool? hasMore,
    String? error,
  }) {
    return PostsState(
      posts: posts ?? this.posts,
      hasMore: hasMore ?? this.hasMore,
      error: error ?? this.error,
    );
  }
}

@Riverpod(keepAlive: true)
class PostsNotifier extends _$PostsNotifier {
  int _limit = 10;
  int _skip = 0;
  bool _canGetMore = true;
  bool _isFetching = false;
  final List<PostMetadata> _posts = [];

  // rebuilds whenever the filter changes
  @override
  FutureOr<PostsState> build() async {
    _limit = 10;
    _skip = 0;
    _canGetMore = true;
    _isFetching = true;
    _posts.clear();
    Either<Failure, List<PostMetadata>> posts;

    // rebuilt when post title searched by user
    final postTitle = ref.watch(postTitleProvider);

    // !!! intentionally reading not watching
    // rebuilding logic handled in explore page via debouncing
    final filters = ref.read(postsFilterProvider);
    final generalFilter = filters.generalFilter;
    final genreFilter = filters.genreFilter;

    if (_isTimeFilter(generalFilter)) {
      posts = await ref
          .read(getFilteredPostsProvider)
          .call(
            GetPostsByTimeParams(
              postTime: _filterToPostTime(generalFilter),
              limit: _limit,
              skip: _skip,
              genre: genreFilter,
            ),
          )
          .run();
    } else if (generalFilter == PostGeneralFilter.popular) {
      posts = await ref
          .read(getFilteredPostsProvider)
          .call(
            GetPopularPostsParams(
              limit: _limit,
              skip: _skip,
              genre: genreFilter,
            ),
          )
          .run();
    } else {
      // search by post title
      posts = await ref
          .read(getPostsByTitleProvider)
          .call(
            GetPostsByTitleParams(title: postTitle, limit: _limit, skip: _skip),
          )
          .run();
    }

    return posts.fold(
      (failure) {
        _isFetching = false;
        _canGetMore = false;
        return PostsState(posts: [], hasMore: false, error: failure.message);
      },
      (data) {
        _posts.addAll(data);
        _canGetMore = data.length == _limit;
        _isFetching = false;
        return PostsState(posts: _posts, hasMore: _canGetMore);
      },
    );
  }

  /// this is a unified method to get the next page of posts based on the current filter
  /// it checks the current filter and calls the appropriate use case to fetch the next page
  Future<void> getNextPage() async {
    if (!_canGetMore || _isFetching) return;
    _isFetching = true;
    _skip += _limit;

    final filters = ref.read(postsFilterProvider);
    final generalFilter = filters.generalFilter;
    final genreFilter = filters.genreFilter;
    final postTitle = ref.read(postTitleProvider);
    Either<Failure, List<PostMetadata>> posts;
    if (_isTimeFilter(generalFilter)) {
      posts = await ref
          .read(getFilteredPostsProvider)
          .call(
            GetPostsByTimeParams(
              postTime: _filterToPostTime(generalFilter),
              limit: _limit,
              skip: _skip,
              genre: genreFilter,
            ),
          )
          .run();
    } else if (generalFilter == PostGeneralFilter.popular) {
      posts = await ref
          .read(getFilteredPostsProvider)
          .call(
            GetPopularPostsParams(
              limit: _limit,
              skip: _skip,
              genre: genreFilter,
            ),
          )
          .run();
    } else {
      posts = await ref
          .read(getPostsByTitleProvider)
          .call(
            GetPostsByTitleParams(title: postTitle, limit: _limit, skip: _skip),
          )
          .run();
    }

    posts.fold(
      (failure) {
        _canGetMore = false;
        _isFetching = false;
        state = AsyncData(
          PostsState(
            posts: _posts,
            hasMore: _canGetMore,
            error: failure.toString(),
          ),
        );
      },
      (data) {
        _posts.addAll(data);
        _canGetMore = data.length == _limit;
        _isFetching = false;
        state = AsyncData(PostsState(posts: _posts, hasMore: _canGetMore));
      },
    );
  }

  bool _isTimeFilter(PostGeneralFilter filter) {
    return filter == PostGeneralFilter.day ||
        filter == PostGeneralFilter.week ||
        filter == PostGeneralFilter.month ||
        filter == PostGeneralFilter.year;
  }

  PostTime _filterToPostTime(PostGeneralFilter filter) {
    assert(
      _isTimeFilter(filter),
      'filter must be a time filter: day, week, month, year',
    );
    switch (filter) {
      case PostGeneralFilter.day:
        return PostTime.day;
      case PostGeneralFilter.week:
        return PostTime.week;
      case PostGeneralFilter.month:
        return PostTime.month;
      case PostGeneralFilter.year:
        return PostTime.year;
      default:
        throw ArgumentError('Invalid filter: $filter');
    }
  }

  void toggleLike(int index) async {
    final postToToggleLike = _posts[index];
    final postId = postToToggleLike.id;
    // toggle like first, handle failure afterwards to reset
    final originalLikeState = postToToggleLike.isLiked;

    // change the state of the post to liked or unliked and increment or decrement like count
    final modifiedPost =
        $PostMetadataModelCopyWith<PostMetadata>(
          PostMetadataModel.fromEntity(postToToggleLike),
          (val) => val.toEntity(),
        ).call(
          isLiked: !originalLikeState,
          likes: originalLikeState
              ? postToToggleLike.likes - 1
              : postToToggleLike.likes + 1,
        );
    _posts[index] = modifiedPost;

    state = AsyncData(PostsState(hasMore: _canGetMore, posts: _posts));

    // send request to backend
    final result = await ref
        .read(togglePostLikeProvider)
        .call(TogglePostParams(postId: postId))
        .run();

    // handle failure and reset the liked state of the post
    if (result.isLeft()) {
      _posts[index] = postToToggleLike;
      result.mapLeft((failure) {
        state = AsyncData(
          PostsState(
            posts: _posts,
            hasMore: _canGetMore,
            error: failure.message,
          ),
        );
      });
    }
  }

  // Future<void> getPostsByTime(PostTime time) async {
  //   state = AsyncLoading();
  //   _skip = 0;
  //   _hasMore = true;

  //   final posts = await ref
  //       .read(getFilteredPostsProvider)
  //       .call(GetPostsByTimeParams(postTime: time, limit: _limit, skip: _skip))
  //       .run();

  //   posts.fold(
  //     (failure) {
  //       state = AsyncData(
  //         PostsState(posts: [], hasMore: false, error: failure.toString()),
  //       );
  //     },
  //     (r) {
  //       _posts.addAll(r);
  //       _hasMore = r.length == _limit;
  //       state = AsyncData(PostsState(posts: _posts, hasMore: _hasMore));
  //     },
  //   );
  // }

  // Future<void> getPostsByTitle(String title) async {
  //   state = AsyncLoading();
  //   _skip = 0;
  //   _hasMore = true;

  //   final posts = await ref
  //       .read(getPostsByTitleProvider)
  //       .call(GetPostsByTitleParams(title: title, limit: _limit, skip: _skip))
  //       .run();

  //   posts.fold(
  //     (failure) {
  //       state = AsyncData(
  //         PostsState(posts: [], hasMore: false, error: failure.toString()),
  //       );
  //     },
  //     (r) {
  //       _posts.addAll(r);
  //       _hasMore = r.length == _limit;
  //       state = AsyncData(PostsState(posts: _posts, hasMore: _hasMore));
  //     },
  //   );
  // }
}
