import 'package:flutter/material.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/features/community/presentation/widgets/stat_counter.dart';

class PostStatCard extends StatelessWidget {
  const PostStatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final int? value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.screenHeight;
    final colorScheme = context.colorScheme;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.02,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withAlpha(150),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: colorScheme.primary, size: 24),
          SizedBox(width: 12),
          value != null ? StatCounter(value: value!) : Text('-'),
          Text(label, style: TextStyle(color: colorScheme.primary)),
        ],
      ),
    );
  }
}
