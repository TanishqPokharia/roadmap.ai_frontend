import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/features/community/domain/entities/post.dart';
import 'package:roadmap_ai/features/community/presentation/widgets/post_like_button.dart';
import 'package:roadmap_ai/router/routes.dart';
import 'package:roadmap_ai/core/themes/colors.dart';

class PostTile extends StatelessWidget {
  const PostTile({super.key, required this.post});
  final Post post;

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;
    final textTheme = context.textTheme;
    return Row(
      spacing: screenWidth * 0.2,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.roadmap.title,
              style: context.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: screenHeight * 0.005),
            Row(
              children: [
                Text(
                  'Created by ${post.author.username}',
                  style: textTheme.bodyMedium!.copyWith(color: Colors.blueGrey),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              post.description,
              style: textTheme.bodyMedium!.copyWith(color: Colors.blueGrey),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: screenHeight * 0.01),
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
                          'title': post.roadmap.title,
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
