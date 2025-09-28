import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/core/utils/format_date.dart';
import 'package:roadmap_ai/features/community/domain/entities/post_metadata.dart';
import 'package:roadmap_ai/features/community/presentation/widgets/post_like_button.dart';
import 'package:roadmap_ai/router/routes.dart';

class PostTile extends StatelessWidget {
  const PostTile({super.key, required this.post});
  final PostMetadata post;

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;
    final textTheme = context.textTheme;
    final theme = context.theme;
    return Row(
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
                Text(
                  'Created by',
                  style: textTheme.bodyMedium!.copyWith(color: Colors.blueGrey),
                ),
                SizedBox(width: screenWidth * 0.005),
                CircleAvatar(
                  radius: screenHeight * 0.012,
                  backgroundImage: NetworkImage(post.author.avatar),
                ),
                Text(
                  '  ${post.author.username}',
                  style: textTheme.bodyMedium!.copyWith(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.005),
            Text(
              'On ${formatDate(post.createdAt)}',
              style: textTheme.bodyMedium!.copyWith(color: Colors.blueGrey),
            ),
            SizedBox(height: screenHeight * 0.02),
            SizedBox(
              width: screenWidth * 0.3,
              child: Text(
                post.description,
                style: textTheme.bodyMedium!.copyWith(color: Colors.blueGrey),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // LayoutBuilder(
            //   builder: (context,constraints) {
            //     return SizedBox(
            //       width: constraints.maxWidth * 0.5,
            //       child: Text(
            //         post.description,
            //         style: textTheme.bodyMedium!.copyWith(color: Colors.blueGrey),
            //         maxLines: 2,
            //         overflow: TextOverflow.ellipsis,
            //       ),
            //     );
            //   }
            // ),
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
                        queryParameters: {
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
                PostLikeButton(likes: post.likes),
              ],
            ),
          ],
        ),
        SizedBox(
          width: screenHeight * 0.2,
          height: screenHeight * 0.12,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              width: screenHeight * 0.2,
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
    );
  }
}
