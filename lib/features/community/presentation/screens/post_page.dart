import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/core/utils/format_date.dart';
import 'package:roadmap_ai/features/community/presentation/providers/post_details/post_details_notifier.dart';
import 'package:roadmap_ai/features/community/presentation/widgets/roadmap_tree.dart';

class PostPage extends ConsumerWidget {
  const PostPage({super.key, required this.postId, required this.title});
  final String postId;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = context.textTheme;
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;
    final colorScheme = context.colorScheme;
    final postDetails = ref.watch(postDetailsNotifierProvider(postId));
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: screenHeight * 0.05,
          right: screenWidth * 0.05,
          left: screenWidth * 0.05,
        ),
        child: postDetails.when(
          loading: () => Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) {
            return Center(
              child: Text(
                'Error loading post: $error',
                style: textTheme.bodyLarge!.copyWith(color: Colors.red),
              ),
            );
          },
          data: (data) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Roadmaps / ',
                      style: textTheme.titleMedium!.copyWith(
                        color: Colors.blueGrey,
                      ),
                      children: [
                        TextSpan(text: title, style: textTheme.titleMedium),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    title,
                    style: textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.02,
                    ),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Posted by ',
                              style: textTheme.bodyMedium!.copyWith(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              data.post.author.username,
                              style: textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                color: colorScheme.primary,
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.01),
                            ClipOval(
                              child: Image.network(
                                data.post.author.avatar,
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.01),
                            Text(
                              'on ${formatDate(data.post.createdAt)}',
                              style: textTheme.bodyMedium!.copyWith(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        Row(
                          spacing: 10,
                          children: [
                            Column(
                              spacing: 5,
                              children: [
                                IconButton.filled(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(
                                      colorScheme.primary.withAlpha(30),
                                    ),
                                    shape: WidgetStatePropertyAll(
                                      CircleBorder(),
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.favorite,
                                    color: Colors.pink,
                                  ),
                                ),
                                Text(
                                  data.post.likes.toString(),
                                  style: textTheme.bodyMedium!.copyWith(
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: screenWidth * 0.01),
                            if (data.isSaved)
                              Column(
                                spacing: 5,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: colorScheme.primary.withAlpha(30),
                                      shape: BoxShape.circle,
                                    ),
                                    padding: EdgeInsets.all(8),
                                    child: Icon(
                                      Icons.bookmark,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  Text(
                                    'Saved',
                                    style: textTheme.bodyMedium!.copyWith(
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        data.post.bannerImage,
                        height: screenWidth * 0.25,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  Center(
                    child: SizedBox(
                      width: screenWidth / 2,
                      child: Text(
                        data.post.description,
                        style: textTheme.titleMedium!.copyWith(
                          color: Colors.blueGrey,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth / 5,
                      top: screenWidth * 0.02,
                    ),
                    child: Text(
                      'Roadmap',
                      style: textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    width: screenWidth / 2,
                    margin: EdgeInsets.only(
                      top: screenWidth * 0.04,
                      left: screenWidth / 5,
                    ),
                    child: RoadmapTree(roadmap: data.post.roadmap),
                  ),
                  SizedBox(height: screenHeight * 0.1),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
