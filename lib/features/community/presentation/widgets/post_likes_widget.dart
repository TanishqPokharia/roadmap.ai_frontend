import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';

class PostLikesWidget extends StatelessWidget {
  const PostLikesWidget({super.key, required this.likes});
  final int likes;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final screenHeight = context.screenHeight;

    if (!kIsWeb && Platform.isAndroid) {
      return Row(
        spacing: 4,
        children: [
          Icon(Icons.favorite_outline, size: 16),
          Text(
            '$likes likes',
            style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      );
    }

    return Row(
      spacing: screenHeight * 0.005,
      children: [
        Icon(Icons.favorite_outline, color: Colors.blueGrey, size: 18),
        Text(
          '$likes likes',
          style: textTheme.bodyLarge!.copyWith(color: Colors.blueGrey),
        ),
      ],
    );
  }
}
