import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/features/community/domain/entities/post_metadata.dart';
import 'package:roadmap_ai/features/community/presentation/providers/posts_stats/posts_stats_notifier.dart';
import 'package:roadmap_ai/features/community/presentation/providers/user_posts/user_posts_notifier.dart';
import 'package:roadmap_ai/features/community/presentation/widgets/no_posts_widget.dart';
import 'package:roadmap_ai/features/community/presentation/widgets/post_stat_card.dart';
import 'package:roadmap_ai/features/community/presentation/widgets/your_post_tile.dart';
import 'package:toastification/toastification.dart';

class YourPostsPage extends ConsumerWidget {
  const YourPostsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = context.textTheme;
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;

    final userPosts = ref.watch(userPostsNotifierProvider);
    final userPostsStats = ref.watch(userPostStatsProvider);
    ref.listen(userPostsNotifierProvider, (_, next) {
      if (next is AsyncError) {
        final error = next.error;
        toastification.show(
          title: Text('Error'),
          description: Text('Error loading posts: $error'),
          backgroundColor: Colors.red,
          icon: Icon(Icons.error, color: Colors.white),
          autoCloseDuration: Duration(seconds: 3),
        );
      }
    });

    ref.listen(userPostStatsProvider, (_, next) {
      if (next is AsyncError) {
        final error = next.error;
        toastification.show(
          title: Text('Error'),
          description: Text('Error loading post stats: $error'),
          backgroundColor: Colors.red,
          icon: Icon(Icons.error, color: Colors.white),
          autoCloseDuration: Duration(seconds: 3),
        );
      }
    });

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
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
