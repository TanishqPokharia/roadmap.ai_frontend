import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:roadmap_ai/core/common/toast/error.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/features/community/presentation/providers/posts/posts_notifier.dart';
import 'package:roadmap_ai/features/community/presentation/widgets/post_filters_card.dart';
import 'package:roadmap_ai/features/community/presentation/widgets/post_tile.dart';

class ExplorePage extends ConsumerStatefulWidget {
  const ExplorePage({super.key});

  @override
  ConsumerState<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends ConsumerState<ExplorePage>
    with AutomaticKeepAliveClientMixin {
  late ScrollController _scrollController;
  final Set<int> _animatedIndexes = {};

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        final notifier = ref.read(postsProvider.notifier);
        if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent) {
          notifier.getNextPage();
        }
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final textTheme = context.textTheme;
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;
    final colorScheme = context.colorScheme;

    final posts = ref.watch(postsProvider);
    ref.listen(postsProvider, (_, next) {
      if (next is AsyncData && next.value?.error != null) {
        showErrorToast(context: context, error: "${next.value?.error}");
      }
    });

    if (!kIsWeb && Platform.isAndroid) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: colorScheme.primaryContainer,
          foregroundColor: colorScheme.primary,
          onPressed: () {
            _showFiltersSheet(context);
          },
          child: Icon(Icons.filter_alt),
        ),
        body: Padding(
          padding: EdgeInsetsGeometry.only(left: 20, right: 20, top: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Roadmaps',
                    style: textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Explore community created roadmaps',
                    style: textTheme.bodyLarge!.copyWith(),
                  ),
                ],
              ),
              Expanded(
                child: posts.when(
                  skipLoadingOnRefresh: false,
                  loading: () => Center(
                    child: LoadingAnimationWidget.threeRotatingDots(
                      color: colorScheme.primary,
                      size: 30,
                    ),
                  ),
                  error: (error, stack) => Center(child: Text('$error')),
                  data: (data) {
                    if (data.posts.isEmpty) {
                      return Center(child: Text('No posts found'));
                    }
                    return RefreshIndicator(
                      onRefresh: () => ref.refresh(postsProvider.future),
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: data.posts.length,
                        padding: EdgeInsets.only(bottom: 100, top: 50),
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(bottom: 40),
                          child: PostTile(
                            post: data.posts[index],
                            index: index,
                            animate: shouldAnimate(index),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeight * 0.04),
          Column(
            spacing: screenHeight * 0.01,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Roadmaps',
                style: textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Explore community created roadmaps',
                style: textTheme.bodyLarge!.copyWith(color: Colors.blueGrey),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.05),
          if (screenWidth < 1300)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PostFiltersCard(
                    width: screenWidth * 0.5,
                    onFilterChange: () => _animatedIndexes.clear(),
                  ),
                  Expanded(
                    child: posts.when(
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (error, stack) =>
                          Center(child: Text('Error: $error')),
                      data: (data) {
                        if (data.posts.isEmpty) {
                          return Center(child: Text('No posts found'));
                        }
                        return ListView.builder(
                          controller: _scrollController,
                          itemCount: data.posts.length,
                          itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.02,
                            ),
                            child: PostTile(
                              post: data.posts[index],
                              index: index,
                              animate: shouldAnimate(index),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          else
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: posts.when(
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (error, stack) =>
                          Center(child: Text('Error: $error')),
                      data: (data) {
                        if (data.posts.isEmpty) {
                          return Center(child: Text('No posts found'));
                        }
                        return ListView.separated(
                          controller: _scrollController,
                          itemCount: data.posts.length,
                          padding: EdgeInsets.only(bottom: 100),
                          separatorBuilder: (context, index) =>
                              SizedBox(height: screenHeight * 0.05),
                          itemBuilder: (context, index) => PostTile(
                            post: data.posts[index],
                            index: index,
                            animate: shouldAnimate(index),
                          ),
                        );
                      },
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.05),
                    child: PostFiltersCard(
                      width: screenHeight * 0.4,
                      onFilterChange: () => _animatedIndexes.clear(),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Future<dynamic> _showFiltersSheet(BuildContext context) {
    final colorScheme = context.colorScheme;
    return showModalBottomSheet(
      context: context,
      backgroundColor: colorScheme.surface,
      showDragHandle: true,
      builder: (context) {
        return Container(
          height: 400,
          margin: EdgeInsets.all(10),
          child: PostFiltersCard(
            onFilterChange: () {
              _animatedIndexes.clear();
            },
          ),
        );
      },
    );
  }

  bool shouldAnimate(int index) {
    return _animatedIndexes.add(index);
  }

  @override
  bool get wantKeepAlive => true;
}
