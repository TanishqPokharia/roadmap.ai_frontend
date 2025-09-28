import 'package:flutter/material.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/features/community/presentation/widgets/stat_counter.dart';

class PostStatCard extends StatefulWidget {
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
  State<PostStatCard> createState() => _PostStatCardState();
}

class _PostStatCardState extends State<PostStatCard> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    final screenHeight = context.screenHeight;
    final theme = context.theme;
    final colorScheme = context.colorScheme;

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        margin: EdgeInsets.symmetric(horizontal: 8),
        padding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.02,
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            if (_isHovered)
              BoxShadow(
                color: colorScheme.primary,
                blurRadius: 10,
                spreadRadius: 2,
              ),
          ],
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
