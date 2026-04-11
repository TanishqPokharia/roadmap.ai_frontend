import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/core/utils/format_date.dart';
import 'package:roadmap_ai/features/community/domain/entities/post_metadata.dart';
import 'package:roadmap_ai/features/community/presentation/providers/posts/posts_notifier.dart';
import 'package:roadmap_ai/features/community/presentation/widgets/post_like_button.dart';
import 'package:roadmap_ai/router/routes.dart';

class PostTile extends ConsumerWidget {
  const PostTile({
    super.key,
    required this.post,
    required this.index,
    required this.animate,
  });
  final int index;
  final PostMetadata post;
  final bool animate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;
    final textTheme = context.textTheme;
    final theme = context.theme;
    final colorScheme = context.colorScheme;

    if (!kIsWeb && Platform.isAndroid) {
      return Animate(
        effects: animate
            ? [
                SlideEffect(
                  delay: Duration(milliseconds: 100 * index),
                  duration: Durations.extralong2,
                  begin: index % 2 == 0 ? Offset(-1, 0) : Offset(1, 0),
                  end: Offset(0, 0),
                  curve: Curves.ease,
                ),
              ]
            : [],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title,
                  style: context.textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      'Posted by  ',
                      style: textTheme.bodyMedium!.copyWith(),
                    ),
                    CircleAvatar(
                      radius: screenHeight * 0.02,
                      backgroundImage: post.author.avatar != null
                          ? NetworkImage(post.author.avatar!)
                          : null,
                      child: post.author.avatar == null
                          ? Icon(Icons.person, color: Colors.white)
                          : null,
                    ),
                    SizedBox(width: 10),
                    Text(
                      post.author.username,
                      style: textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  'On ${formatDate(post.createdAt)}',
                  style: textTheme.bodyMedium!.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      height: 140,
                      width: 300,
                      child: Image.network(
                        width: 300,
                        height: 200,
                        fit: BoxFit.cover,
                        post.bannerImage,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Icon(
                              Icons.broken_image,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                SizedBox(
                  width: screenWidth - 50,
                  child: Text(
                    post.description,
                    style: textTheme.bodyMedium?.copyWith(),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                SizedBox(height: screenHeight * 0.02),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  spacing: 10,
                  children: [
                    GestureDetector(
                      onTap: () {
                        ref.read(postsProvider.notifier).toggleLike(index);
                      },
                      child: AnimatedContainer(
                        duration: Durations.long1,
                        child: Row(
                          spacing: 10,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              post.isLiked
                                  ? Icons.favorite
                                  : Icons.favorite_outline,
                              color: post.isLiked
                                  ? Colors.red
                                  : Colors.blueGrey,
                            ),
                            Text('${post.likes} likes'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: screenHeight * 0.01),
                    FilledButton(
                      onPressed: () {
                        context.goNamed(
                          AppRoutes.post,
                          pathParameters: {
                            'postId': post.id,
                            'title': post.title,
                          },
                        );
                      },
                      child: Text('View'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }
    return Animate(
      effects: animate
          ? [
              FadeEffect(
                delay: Duration(milliseconds: 200 * index),
                duration: Duration(seconds: 1, milliseconds: 500),
              ),
              SlideEffect(
                delay: Duration(milliseconds: 100 * index),
                duration: Durations.extralong2,
                begin: index % 2 == 0 ? Offset(-1, 0) : Offset(1, 0),
                end: Offset(0, 0),
                curve: Curves.fastEaseInToSlowEaseOut,
              ),
            ]
          : [],
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.title,
                style: context.textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: screenHeight * 0.005),
              Row(
                children: [
                  Text('Posted by', style: textTheme.bodyLarge!.copyWith()),
                  SizedBox(width: screenWidth * 0.005),
                  CircleAvatar(
                    radius: screenHeight * 0.02,
                    backgroundImage: post.author.avatar != null
                        ? NetworkImage(post.author.avatar!)
                        : null,
                    child: post.author.avatar == null
                        ? Icon(Icons.person, color: Colors.white)
                        : null,
                  ),
                  Text(
                    '  ${post.author.username}',
                    style: textTheme.bodyLarge!.copyWith(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.005),
              Text(
                'On ${formatDate(post.createdAt)}',
                style: textTheme.bodyMedium!.copyWith(
                  color: Colors.blueGrey.shade300,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              SizedBox(
                width: screenWidth * 0.3,
                child: Text(
                  post.description,
                  style: textTheme.bodyLarge,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              SizedBox(height: screenHeight * 0.02),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: screenHeight * 0.005,
                children: [
                  SizedBox(
                    height: screenHeight * 0.035,
                    width: screenHeight * 0.08,
                    child: FilledButton(
                      onPressed: () {
                        // Add view functionality here
                        context.goNamed(
                          AppRoutes.post,
                          pathParameters: {
                            'postId': post.id,
                            'title': post.title,
                          },
                        );
                      },
                      style: theme.filledButtonTheme.style?.copyWith(
                        textStyle: WidgetStatePropertyAll(textTheme.bodyLarge),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        padding: WidgetStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                      ),
                      child: Text(
                        'View',
                        style: textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: screenHeight * 0.01),
                  PostLikeButton(
                    likes: post.likes,
                    onLike: () {
                      ref.read(postsProvider.notifier).toggleLike(index);
                    },
                    isLiked: post.isLiked,
                  ),
                ],
              ),
            ],
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              width: screenHeight * 0.25,
              fit: BoxFit.contain,
              post.bannerImage,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.broken_image, color: Colors.grey),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
