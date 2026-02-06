import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadmap_ai/core/common/widgets/animated_shadow.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/core/utils/debouncer.dart';
import 'package:roadmap_ai/features/community/presentation/providers/post_title/post_title_notifier.dart';
import 'package:roadmap_ai/features/community/presentation/providers/posts_filter/posts_filter_notifier.dart';

final postFilterChipMap = {
  PostFilter.popular: 'Popular',
  PostFilter.day: 'Past Day',
  PostFilter.week: 'Past Week',
  PostFilter.month: 'Past Month',
  PostFilter.year: 'Past Year',
};

class PostFiltersCard extends ConsumerStatefulWidget {
  const PostFiltersCard({super.key, this.width, required this.onFilterChange});
  final double? width;
  final VoidCallback onFilterChange;

  @override
  ConsumerState<PostFiltersCard> createState() => _PostFiltersCardState();
}

class _PostFiltersCardState extends ConsumerState<PostFiltersCard> {
  late TextEditingController _textEditingController;
  final Debouncer _debouncer = Debouncer(duration: Duration(seconds: 1));

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    return AnimatedShadow(
      borderRadius: BorderRadius.circular(10),
      shadowColor: colorScheme.primary,
      child: SizedBox(
        width: widget.width,
        child: Card(
          color: colorScheme.surface,
          elevation: 10,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Filters',
                  style: textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: _textEditingController,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      _debouncer.debounce(() {
                        widget.onFilterChange();
                        ref.read(postTitleProvider.notifier).setTitle(value);
                        ref
                            .read(postsFilterProvider.notifier)
                            .setFilter(PostFilter.title);
                      });
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                ),
                SizedBox(height: screenWidth * 0.01),
                Text(
                  'Sort by',
                  style: textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Wrap(
                  spacing: 10,
                  runSpacing: 20,
                  children: postFilterChipMap.entries
                      .map(
                        (e) => SizedBox(
                          height: 40,
                          child: ChoiceChip(
                            checkmarkColor: colorScheme.primary,
                            label: Text(e.value),
                            selected: ref.watch(postsFilterProvider) == e.key,
                            onSelected: (selected) {
                              widget.onFilterChange();
                              ref
                                  .read(postsFilterProvider.notifier)
                                  .setFilter(e.key);
                            },
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
