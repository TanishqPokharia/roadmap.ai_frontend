import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:roadmap_ai/core/common/toast/error.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/features/community/domain/entities/post_metadata.dart';
import 'package:roadmap_ai/features/community/presentation/providers/posts_stats/posts_stats_notifier.dart';
import 'package:roadmap_ai/features/community/presentation/providers/user_posts/user_posts_notifier.dart';
import 'package:roadmap_ai/features/community/presentation/widgets/no_posts_widget.dart';
import 'package:roadmap_ai/features/community/presentation/widgets/post_stat_card.dart';
import 'package:roadmap_ai/features/community/presentation/widgets/your_post_tile.dart';

class YourPostsPage extends ConsumerStatefulWidget {
  const YourPostsPage({super.key});

  @override
  ConsumerState<YourPostsPage> createState() => _YourPostsPageState();
}

class _YourPostsPageState extends ConsumerState<YourPostsPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        final notifier = ref.read(userPostsProvider.notifier);
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
    final textTheme = context.textTheme;
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;
    final colorScheme = context.colorScheme;
    final userPosts = ref.watch(userPostsProvider);
    final userPostsStats = ref.watch(userPostStatsProvider);
    ref.listen(userPostsProvider, (_, next) {
      if (next is AsyncError) {
        final error = next.error;
        showErrorToast(context: context, error: 'Error loading posts: $error');
      }
    });

    ref.listen(userPostStatsProvider, (_, next) {
      if (next is AsyncError) {
        final error = next.error;
        showErrorToast(
          context: context,
          error: 'Error loading post stats: $error',
        );
      }
    });

    if (!kIsWeb && Platform.isAndroid) {
      return Scaffold(
        body: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 30),
          child: RefreshIndicator(
            onRefresh: () {
              return Future.wait([
                ref.refresh(userPostStatsProvider.future),
                ref.refresh(userPostsProvider.future),
              ]);
            },
            child: ListView(
              controller: _scrollController,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Posts',
                          style: textTheme.headlineMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Manage and track your published roadmaps',
                          style: textTheme.bodyLarge!.copyWith(),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.03),

                    userPostsStats.maybeWhen(
                      skipLoadingOnRefresh: false,
                      data: (posts) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          spacing: 20,
                          children: [
                            Expanded(
                              child: PostStatCard(
                                icon: Icons.article,
                                value: posts.totalPosts,
                                label: 'Posts',
                                textStyle: textTheme.bodyLarge,
                              ),
                            ),
                            Expanded(
                              child: PostStatCard(
                                icon: Icons.visibility,
                                value: posts.totalViews,
                                label: 'Total Views',
                                textStyle: textTheme.bodyLarge,
                              ),
                            ),
                            Expanded(
                              child: PostStatCard(
                                icon: Icons.favorite,
                                value: posts.totalLikes,
                                label: 'Total Likes',
                                textStyle: textTheme.bodyLarge,
                              ),
                            ),
                          ],
                        );
                      },
                      orElse: () {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          spacing: 20,
                          children: [
                            Expanded(
                              child: PostStatCard(
                                icon: Icons.article,
                                value: null,
                                label: 'Posts',
                              ),
                            ),
                            Expanded(
                              child: PostStatCard(
                                icon: Icons.visibility,
                                value: null,
                                label: 'Total Views',
                              ),
                            ),
                            Expanded(
                              child: PostStatCard(
                                icon: Icons.favorite,
                                value: null,
                                label: 'Total Likes',
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    userPosts.when(
                      skipLoadingOnRefresh: false,
                      data: (data) => data.isEmpty
                          ? const NoPostsWidget()
                          : Builder(
                              builder: (context) {
                                final List<PostMetadata> sortedPosts =
                                    List.from(data);
                                sortedPosts.sort(
                                  (a, b) => b.createdAt.compareTo(a.createdAt),
                                );
                                return ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.only(
                                    bottom: 100,
                                    top: 10,
                                  ),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: screenHeight * 0.03),
                                  itemCount: sortedPosts.length,
                                  itemBuilder: (context, index) {
                                    final post = sortedPosts[index];
                                    return YourPostTile(
                                      post: post,
                                      views: post.views,
                                    );
                                  },
                                );
                              },
                            ),
                      loading: () => Padding(
                        padding: EdgeInsets.only(top: screenHeight / 4),
                        child: Center(
                          child: LoadingAnimationWidget.threeRotatingDots(
                            color: colorScheme.primary,
                            size: 30,
                          ),
                        ),
                      ),
                      error: (error, stack) => Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 64,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Failed to load posts',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.04),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Posts',
                      style: textTheme.headlineLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Manage and track your published roadmaps',
                      style: textTheme.bodyLarge!.copyWith(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),

                userPostsStats.maybeWhen(
                  data: (posts) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      spacing: 20,
                      children: [
                        Expanded(
                          child: PostStatCard(
                            icon: Icons.article,
                            value: posts.totalPosts,
                            label: 'Posts',
                          ),
                        ),
                        Expanded(
                          child: PostStatCard(
                            icon: Icons.visibility,
                            value: posts.totalViews,
                            label: 'Total Views',
                          ),
                        ),
                        Expanded(
                          child: PostStatCard(
                            icon: Icons.favorite,
                            value: posts.totalLikes,
                            label: 'Total Likes',
                          ),
                        ),
                      ],
                    );
                  },
                  orElse: () {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      spacing: 20,
                      children: [
                        Expanded(
                          child: PostStatCard(
                            icon: Icons.article,
                            value: null,
                            label: 'Posts',
                          ),
                        ),
                        Expanded(
                          child: PostStatCard(
                            icon: Icons.visibility,
                            value: null,
                            label: 'Total Views',
                          ),
                        ),
                        Expanded(
                          child: PostStatCard(
                            icon: Icons.favorite,
                            value: null,
                            label: 'Total Likes',
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: screenHeight * 0.03),
                userPosts.when(
                  data: (data) => data.isEmpty
                      ? const NoPostsWidget()
                      : Builder(
                          builder: (context) {
                            final List<PostMetadata> sortedPosts = List.from(
                              data,
                            );
                            sortedPosts.sort(
                              (a, b) => b.createdAt.compareTo(a.createdAt),
                            );
                            return ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(bottom: 100),
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: screenHeight * 0.03),
                              itemCount: sortedPosts.length,
                              itemBuilder: (context, index) {
                                final post = sortedPosts[index];
                                return YourPostTile(
                                  post: post,
                                  views: post.views,
                                );
                              },
                            );
                          },
                        ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'Failed to load posts',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
