import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/features/community/presentation/providers/posts/posts_notifier.dart';
import 'package:roadmap_ai/features/community/presentation/widgets/post_filters_card.dart';
import 'package:roadmap_ai/features/community/presentation/widgets/post_tile.dart';
import 'package:toastification/toastification.dart';

class ExplorePage extends ConsumerWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = context.textTheme;
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;

    final posts = ref.watch(postsNotifierProvider);
    ref.listen(postsNotifierProvider, (_, next) {
      if (next is AsyncData && next.value?.error != null) {
        toastification.show(
          title: Text('Error'),
          description: Text("${next.value?.error}"),
          type: ToastificationType.error,
          style: ToastificationStyle.minimal,
          autoCloseDuration: Duration(seconds: 3),
          showProgressBar: true,
        );
      }
    });

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
                  PostFiltersCard(),
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
                          itemCount: data.posts.length,
                          itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.02,
                            ),
                            child: PostTile(post: data.posts[index]),
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
                        return ListView.builder(
                          itemCount: data.posts.length,
                          itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.02,
                            ),
                            child: PostTile(post: data.posts[index]),
                          ),
                        );
                      },
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.05),
                    child: PostFiltersCard(),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
