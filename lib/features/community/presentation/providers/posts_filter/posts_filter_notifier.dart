// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/utils/post_filters.dart';

part 'posts_filter_notifier.g.dart';

class PostsFilterState {
  final PostGeneralFilter generalFilter;
  final List<PostGenreFilter> genreFilter;

  PostsFilterState({required this.generalFilter, required this.genreFilter});

  PostsFilterState copyWith({
    PostGeneralFilter? generalFilter,
    List<PostGenreFilter>? genreFilter,
  }) {
    return PostsFilterState(
      generalFilter: generalFilter ?? this.generalFilter,
      genreFilter: genreFilter ?? this.genreFilter,
    );
  }
}

@Riverpod(keepAlive: true)
class PostsFilter extends _$PostsFilter {
  @override
  PostsFilterState build() {
    return PostsFilterState(
      generalFilter: PostGeneralFilter.popular,
      genreFilter: [],
    );
  }

  void setGeneralFilter(PostGeneralFilter filter) {
    state = state.copyWith(generalFilter: filter);
  }

  void toggleGenreFilter(PostGenreFilter filter) {
    if (state.genreFilter.contains(filter)) {
      state = state.copyWith(
        genreFilter: List.from(state.genreFilter)..remove(filter),
      );
    } else {
      state = state.copyWith(genreFilter: [...state.genreFilter, filter]);
    }
  }
}
