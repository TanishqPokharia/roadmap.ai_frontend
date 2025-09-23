import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/features/auth/presentation/providers/login/login_notifier.dart';
import 'package:roadmap_ai/features/community/domain/entities/post_metadata.dart';
import 'package:roadmap_ai/features/community/domain/usecases/get_user_posts_metadata/get_user_posts_metadata.dart';

part 'user_posts_notifier.g.dart';

@Riverpod(keepAlive: true)
class UserPostsNotifier extends _$UserPostsNotifier {
  final int _limit = 10;
  int _skip = 0;
  final List<PostMetadata> _posts = [];
  bool _canGetMore = true;

  @override
  FutureOr<List<PostMetadata>> build() async {
    ref.watch(loginNotifierProvider);
    _skip = 0;
    _posts.clear();
    _canGetMore = true;

    final posts = await ref
        .read(getUserPostsMetaDataProvider)
        .call(GetUserPostsMetadataParams(limit: _limit, skip: _skip))
        .run();

    return posts.fold(
      (failure) {
        throw failure;
      },
      (posts) {
        _posts.addAll(posts);

        if (posts.length < _limit) {
          _canGetMore = false;
        }

        return _posts;
      },
    );
  }

  void reset() {
    _skip = 0;
    _posts.clear();
    _canGetMore = true;
    ref.invalidateSelf();
  }

  void getNextPage() async {
    if (!_canGetMore) return;
    state = const AsyncLoading();
    _skip += _limit;
    final posts = await ref
        .read(getUserPostsMetaDataProvider)
        .call(GetUserPostsMetadataParams(limit: _limit, skip: _skip))
        .run();
    posts.fold(
      (failure) {
        _canGetMore = false;
        // Return current state on error
        state = AsyncData(_posts);
      },
      (posts) {
        if (posts.length < _limit) {
          _canGetMore = false;
        }
        _posts.addAll(posts);
        state = AsyncData(_posts);
      },
    );
  }
}
