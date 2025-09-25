import 'package:flutter/material.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/features/community/domain/entities/post_metadata.dart';
import 'package:roadmap_ai/features/community/presentation/widgets/post_likes_widget.dart';
import 'package:roadmap_ai/features/community/presentation/widgets/post_views_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:roadmap_ai/router/routes.dart';
import 'package:roadmap_ai/core/themes/colors.dart';

class YourPostTile extends StatelessWidget {
  const YourPostTile({super.key, required this.post, required this.views});
  final PostMetadata post;
  final int views;

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;
    final textTheme = context.textTheme;

    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: screenHeight * 0.02),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
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
                  post.title,
                  style: context.textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'Posted on ${_formatDate(post.createdAt)}',
                  style: textTheme.bodyMedium!.copyWith(color: Colors.blueGrey),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  post.description,
                  style: textTheme.bodyMedium!,
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
                            queryParameters: {
                              'postId': post.id,
                              'title': post.title,
                            },
                          );
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: buttonColor,
                          textStyle: textTheme.bodyLarge,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                        ),
                        child: Text(
                          'View',
                          style: textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    PostViewsWidget(views: views),
                    SizedBox(width: screenHeight * 0.01),
                    PostLikesWidget(likes: post.likes),
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
                    child: const Icon(Icons.broken_image, color: Colors.grey),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
