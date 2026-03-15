import 'package:flutter/material.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';

class NoPostsWidget extends StatelessWidget {
  const NoPostsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.post_add, size: 80, color: colorScheme.primary),
          SizedBox(height: 16),
          Text(
            'No posts yet',
            style: textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Create and share your first roadmap!',
            style: textTheme.bodyMedium!.copyWith(color: colorScheme.onSurface),
          ),
          SizedBox(height: 24),
          // FilledButton.icon(
          //   onPressed: () {
          //     // Navigate to create roadmap

          //   },
          //   icon: Icon(Icons.add),
          //   label: Text('Create Roadmap'),
          // ),
        ],
      ),
    );
  }
}
