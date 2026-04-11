// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/features/community/domain/entities/post_author.dart';
import 'package:roadmap_ai/features/community/domain/entities/post_metadata.dart';
import 'package:roadmap_ai/features/community/domain/usecases/get_posts_by_author/get_posts_by_author.dart';

part 'author_posts.notifier.g.dart';

class AuthorPostsState {
  final List<PostMetadata> posts;
  final PostAuthor? author;
  final bool hasMore;
  final String? error;

  AuthorPostsState({
    required this.posts,
    required this.hasMore,
    this.error,
    this.author,
  });

  AuthorPostsState copyWith({
    List<PostMetadata>? posts,
    PostAuthor? author,
    bool? hasMore,
    String? error,
  }) {
    return AuthorPostsState(
      posts: posts ?? this.posts,
      author: author ?? this.author,
      hasMore: hasMore ?? this.hasMore,
      error: error ?? this.error,
    );
  }
}

@riverpod
class AuthorPostsNotifier extends _$AuthorPostsNotifier {
  final int _limit = 10;
  late String _authorId;
  int _skip = 0;
  bool _canGetMore = true;
  bool _isFetching = false;
  final List<PostMetadata> _posts = [];

  @override
  FutureOr<AuthorPostsState> build(String authorId) async {
    _skip = 0;
    _canGetMore = true;
    _isFetching = true;
    _authorId = authorId;
    _posts.clear();

    final posts = await ref
        .read(getPostsByAuthorProvider)
        .call(
          GetPostsByAuthorParams(
            limit: _limit,
            skip: _skip,
            authorId: authorId,
          ),
        )
        .run();
    return posts.fold(
      (failure) {
        _isFetching = false;
        _canGetMore = false;
        return AuthorPostsState(
          hasMore: false,
          posts: _posts,
          error: failure.message,
        );
      },
      (posts) {
        _posts.addAll(posts);
        _canGetMore = posts.length == _limit;
        _isFetching = false;
        return AuthorPostsState(
          posts: _posts,
          hasMore: _canGetMore,
          author: posts[0].author,
        );
      },
    );
  }

  void getNextPage() async {
    if (!_canGetMore || _isFetching) return;
    _isFetching = true;
    _skip += _limit;
    final posts = await ref
        .read(getPostsByAuthorProvider)
        .call(
          GetPostsByAuthorParams(
            limit: _limit,
            skip: _skip,
            authorId: _authorId,
          ),
        )
        .run();
    posts.fold(
      (failure) {
        _canGetMore = false;
        _isFetching = false;
        // Return current state on error
        state = AsyncData(
          AuthorPostsState(
            posts: _posts,
            hasMore: false,
            author: _posts[0].author,
          ),
        );
      },
      (posts) {
        _canGetMore = posts.length == _limit;
        _posts.addAll(posts);
        _isFetching = false;
        state = AsyncData(
          AuthorPostsState(
            hasMore: _canGetMore,
            posts: _posts,
            author: _posts[0].author,
          ),
        );
      },
    );
  }
}
