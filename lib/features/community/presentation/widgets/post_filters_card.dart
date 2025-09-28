import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  const PostFiltersCard({super.key});

  @override
  ConsumerState<PostFiltersCard> createState() => _PostFiltersCardState();
}

class _PostFiltersCardState extends ConsumerState<PostFiltersCard> {
  bool _isHovered = false;

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
    final theme = context.theme;
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            if (_isHovered)
              BoxShadow(
                color: colorScheme.primary.withAlpha(150),
                blurRadius: 10,
                spreadRadius: 3,
              ),
          ],
        ),
        width: screenWidth * 0.25,
        child: Card(
          color: theme.cardColor,
          elevation: 5,
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
                        ref
                            .read(postTitleNotifierProvider.notifier)
                            .setTitle(value);
                        ref
                            .read(postsFilterNotifierProvider.notifier)
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
                  runSpacing: 10,
                  children: postFilterChipMap.entries
                      .map(
                        (e) => ChoiceChip(
                          label: Text(e.value),
                          selected:
                              ref.watch(postsFilterNotifierProvider) == e.key,
                          onSelected: (selected) {
                            ref
                                .read(postsFilterNotifierProvider.notifier)
                                .setFilter(e.key);
                          },
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
