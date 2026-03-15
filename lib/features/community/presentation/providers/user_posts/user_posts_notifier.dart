import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/features/community/domain/entities/post_metadata.dart';
import 'package:roadmap_ai/features/community/domain/usecases/get_user_posts_metadata/get_user_posts_metadata.dart';

part 'user_posts_notifier.g.dart';

@Riverpod(keepAlive: true)
class UserPostsNotifier extends _$UserPostsNotifier {
  final int _limit = 10;
  int _skip = 0;
  final List<PostMetadata> _posts = [];
  bool _canGetMore = true;
  bool _isFetching = false;

  @override
  FutureOr<List<PostMetadata>> build() async {
    _skip = 0;
    _posts.clear();
    _canGetMore = true;
    _isFetching = true;

    final posts = await ref
        .read(getUserPostsMetaDataProvider)
        .call(GetUserPostsMetadataParams(limit: _limit, skip: _skip))
        .run();

    return posts.fold(
      (failure) {
        _isFetching = false;
        throw failure;
      },
      (posts) {
        _posts.addAll(posts);
        _canGetMore = posts.length == _limit;

        _isFetching = false;

        return _posts;
      },
    );
  }

  void reset() {
    _skip = 0;
    _posts.clear();
    _canGetMore = true;
    _isFetching = false;
    ref.invalidateSelf();
  }

  void getNextPage() async {
    if (!_canGetMore || _isFetching) return;
    _isFetching = true;
    _skip += _limit;
    final posts = await ref
        .read(getUserPostsMetaDataProvider)
        .call(GetUserPostsMetadataParams(limit: _limit, skip: _skip))
        .run();
    posts.fold(
      (failure) {
        _canGetMore = false;
        _isFetching = false;
        // Return current state on error
        state = AsyncData(_posts);
      },
      (posts) {
        _canGetMore = posts.length == _limit;
        _posts.addAll(posts);
        _isFetching = false;
        state = AsyncData(_posts);
      },
    );
  }
}
