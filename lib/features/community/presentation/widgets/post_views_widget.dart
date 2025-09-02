import 'package:flutter/material.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';

class PostViewsWidget extends StatelessWidget {
  const PostViewsWidget({super.key, required this.views});
  final int views;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final screenHeight = context.screenHeight;

    return Row(
      spacing: screenHeight * 0.005,
      children: [
        Icon(
          Icons.visibility_outlined,
          color: Colors.blueGrey,
          size: 18,
        ),
        Text(
          '$views views',
          style: textTheme.bodySmall!.copyWith(color: Colors.blueGrey),
        ),
      ],
    );
  }
}