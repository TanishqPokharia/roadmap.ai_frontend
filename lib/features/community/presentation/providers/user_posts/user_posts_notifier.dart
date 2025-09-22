import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/features/community/domain/entities/post_metadata.dart';
import 'package:roadmap_ai/features/community/domain/usecases/get_user_posts_metadata/get_user_posts_metadata.dart';

part 'user_posts_notifier.g.dart';

@Riverpod(keepAlive: true)
class UserPostsNotifier extends _$UserPostsNotifier {
  final int _limit = 10;
  int _skip = 0;
  bool _hasMore = true;
  final List<PostMetadata> _posts = [];
  @override
  FutureOr<List<PostMetadata>> build() async {
    final posts = await ref
        .read(getUserPostsMetaDataProvider)
        .call(GetUserPostsMetadataParams(limit: _limit, skip: _skip))
        .run();
    return posts.fold((failure) => throw failure, (posts) {
      if (posts.length < _limit) {
        _hasMore = false;
      }
      _posts.addAll(posts);
      return _posts;
    });
  }

  void getNextPage() async {
    if (!_hasMore) return;
    state = const AsyncLoading();
    _skip += _limit;
    final posts = await ref
        .read(getUserPostsMetaDataProvider)
        .call(GetUserPostsMetadataParams(limit: _limit, skip: _skip))
        .run();
    posts.fold(
      (failure) {
        _hasMore = false;
      },
      (posts) {
        if (posts.length < _limit) {
          _hasMore = false;
        }
        _posts.addAll(posts);
        state = AsyncData(_posts);
      },
    );
  }
}
