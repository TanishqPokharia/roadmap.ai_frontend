import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:roadmap_ai/core/common/widgets/animated_shadow.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/features/community/presentation/widgets/stat_counter.dart';

class PostStatCard extends StatefulWidget {
  const PostStatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    this.textStyle,
  });

  final IconData icon;
  final int? value;
  final String label;
  final TextStyle? textStyle;

  @override
  State<PostStatCard> createState() => _PostStatCardState();
}

class _PostStatCardState extends State<PostStatCard> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = context.screenHeight;
    final theme = context.theme;
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;

    if (!kIsWeb && Platform.isAndroid) {
      return Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(widget.icon, color: colorScheme.primary, size: 16),
            SizedBox(width: 12),
            widget.value != null
                ? StatCounter(value: widget.value!, textStyle: widget.textStyle)
                : Text('-'),
            Text(
              widget.label,
              textAlign: TextAlign.center,
              style: textTheme.labelMedium?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
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
        padding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.02,
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.icon, color: colorScheme.primary, size: 24),
            SizedBox(width: 12),
            widget.value != null
                ? StatCounter(value: widget.value!)
                : Text('-'),
            Text(widget.label, style: TextStyle(color: colorScheme.primary)),
          ],
        ),
      ),
    );
  }
}
