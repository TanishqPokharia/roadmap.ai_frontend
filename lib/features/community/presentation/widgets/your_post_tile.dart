import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:roadmap_ai/core/common/widgets/animated_shadow.dart';
import 'package:roadmap_ai/core/constants/constants.dart';
import 'package:roadmap_ai/core/extensions/datetime_utility_extension.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/features/community/domain/entities/post_metadata.dart';
import 'package:roadmap_ai/features/community/presentation/widgets/post_likes_widget.dart';
import 'package:roadmap_ai/features/community/presentation/widgets/post_views_widget.dart';
import 'package:roadmap_ai/router/routes.dart';

class YourPostTile extends StatefulWidget {
  const YourPostTile({super.key, required this.post, required this.views});
  final PostMetadata post;
  final int views;

  @override
  State<YourPostTile> createState() => _YourPostTileState();
}

class _YourPostTileState extends State<YourPostTile> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;
    final textTheme = context.textTheme;
    final theme = context.theme;
    final colorScheme = context.colorScheme;

    if (AppConstants.isAndroid) {
      return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Row(
          spacing: screenWidth * 0.03,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.post.title,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    'Posted on ${widget.post.createdAt.formatDate()}',
                    style: textTheme.bodyMedium!.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                        child: Image.network(
                          widget.post.bannerImage,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value:
                                    loadingProgress.expectedTotalBytes != null
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
                  SizedBox(height: 10),
                  Text(
                    widget.post.description,
                    style: textTheme.bodyMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: screenHeight * 0.01,
                    children: [
                      PostViewsWidget(views: widget.views),
                      SizedBox(width: screenHeight * 0.01),
                      PostLikesWidget(likes: widget.post.likes),
                      Spacer(),
                      FilledButton(
                        onPressed: () {
                          context.goNamed(
                            AppRoutes.post,
                            pathParameters: {
                              'postId': widget.post.id,
                              'title': widget.post.title,
                            },
                          );
                        },
                        child: Text('View'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return AnimatedShadow(
      shadowColor: colorScheme.primary,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: theme.cardColor,
        ),
        child: Row(
          spacing: screenWidth * 0.03,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.post.title,
                    style: context.textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    'Posted on ${(widget.post.createdAt).formatDate()}',
                    style: textTheme.bodyLarge!.copyWith(
                      color: Colors.blueGrey,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    widget.post.description,
                    style: textTheme.bodyLarge!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: screenHeight * 0.01,
                    children: [
                      SizedBox(
                        height: screenHeight * 0.035,
                        child: FilledButton(
                          onPressed: () {
                            context.goNamed(
                              AppRoutes.post,
                              pathParameters: {
                                'postId': widget.post.id,
                                'title': widget.post.title,
                              },
                            );
                          },
                          style: theme.filledButtonTheme.style?.copyWith(
                            textStyle: WidgetStatePropertyAll(
                              textTheme.bodyLarge,
                            ),
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            padding: WidgetStatePropertyAll(
                              EdgeInsets.symmetric(horizontal: 28, vertical: 8),
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
                      Spacer(),
                      PostViewsWidget(views: widget.views),
                      SizedBox(width: screenHeight * 0.01),
                      PostLikesWidget(likes: widget.post.likes),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: screenHeight * 0.2,
              height: screenHeight * 0.12,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.post.bannerImage,
                  fit: BoxFit.cover,
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
            ),
          ],
        ),
      ),
    );
  }
}
