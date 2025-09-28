import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'posts_filter_notifier.g.dart';

enum PostFilter { popular, day, week, month, year, title }

@Riverpod(keepAlive: true)
class PostsFilter extends _$PostsFilter {
  @override
  PostFilter build() {
    return PostFilter.popular;
  }

  void setFilter(PostFilter filter) {
    state = filter;
  }
}
