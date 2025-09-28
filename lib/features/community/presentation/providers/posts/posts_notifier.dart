import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/utils/failures.dart';
import 'package:roadmap_ai/features/community/data/datasource/interface/post_datasource.dart';
import 'package:roadmap_ai/features/community/domain/entities/post_metadata.dart';
import 'package:roadmap_ai/features/community/domain/usecases/get_filtered_posts/get_filtered_posts.dart';
import 'package:roadmap_ai/features/community/domain/usecases/get_posts_by_title/get_posts_by_title.dart';
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
  bool _hasMore = true;
  final List<PostMetadata> _posts = [];

  // rebuilds whenever the filter changes
  @override
  FutureOr<PostsState> build() async {
    _limit = 10;
    _skip = 0;
    _hasMore = true;
    _posts.clear();

    Either<Failure, List<PostMetadata>> posts;

    // rebuilt when post title searched by user
    final postTitle = ref.watch(postTitleNotifierProvider);

    // rebuilt when filter added by user
    final filter = ref.watch(postsFilterNotifierProvider);

    if (isTimeFilter(filter)) {
      posts = await ref
          .read(getFilteredPostsProvider)
          .call(
            GetPostsByTimeParams(
              postTime: filterToPostTime(filter),
              limit: _limit,
              skip: _skip,
            ),
          )
          .run();
    } else if (filter == PostFilter.popular) {
      posts = await ref
          .read(getFilteredPostsProvider)
          .call(GetPopularPostsParams(limit: _limit, skip: _skip))
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
      (failure) =>
          PostsState(posts: [], hasMore: false, error: failure.toString()),
      (r) {
        _posts.addAll(r);
        _hasMore = r.length == _limit;
        return PostsState(posts: _posts, hasMore: _hasMore);
      },
    );
  }

  /// this is a unified method to get the next page of posts based on the current filter
  /// it checks the current filter and calls the appropriate use case to fetch the next page
  Future<void> getNextPage(String? title) async {
    if (!_hasMore) return;
    _skip += _limit;
    final filter = ref.read(postsFilterNotifierProvider);
    Either<Failure, List<PostMetadata>> posts;
    if (isTimeFilter(filter)) {
      posts = await ref
          .read(getFilteredPostsProvider)
          .call(
            GetPostsByTimeParams(
              postTime: filterToPostTime(filter),
              limit: _limit,
              skip: _skip,
            ),
          )
          .run();
    } else {
      posts = await ref
          .read(getFilteredPostsProvider)
          .call(GetPopularPostsParams(limit: _limit, skip: _skip))
          .run();
    }

    posts.fold(
      (failure) {
        state = AsyncData(
          PostsState(
            posts: _posts,
            hasMore: _hasMore,
            error: failure.toString(),
          ),
        );
      },
      (r) {
        _posts.addAll(r);
        _hasMore = r.length == _limit;
        state = AsyncData(PostsState(posts: _posts, hasMore: _hasMore));
      },
    );
  }

  bool isTimeFilter(PostFilter filter) {
    return filter == PostFilter.day ||
        filter == PostFilter.week ||
        filter == PostFilter.month ||
        filter == PostFilter.year;
  }

  PostTime filterToPostTime(PostFilter filter) {
    assert(
      isTimeFilter(filter),
      'filter must be a time filter: day, week, month, year',
    );
    switch (filter) {
      case PostFilter.day:
        return PostTime.day;
      case PostFilter.week:
        return PostTime.week;
      case PostFilter.month:
        return PostTime.month;
      case PostFilter.year:
        return PostTime.year;
      default:
        throw ArgumentError('Invalid filter: $filter');
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
