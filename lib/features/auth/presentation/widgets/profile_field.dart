import 'package:flutter/material.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';

class ProfileField extends StatelessWidget {
  const ProfileField({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenWidth;
    final colorScheme = context.colorScheme;
    final screenHeight = context.screenHeight;
    final textTheme = context.textTheme;
    return Container(
      width: screenWidth * 0.2,
      decoration: BoxDecoration(
        border: Border.all(color: context.colorScheme.primary, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Icon(icon, color: colorScheme.primary),
          ),
          Container(
            width: 2,
            height: screenHeight * 0.03,
            color: colorScheme.primary,
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              text,
              style: textTheme.titleMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: false,
            ),
          ),
        ],
      ),
    );
  }
}
