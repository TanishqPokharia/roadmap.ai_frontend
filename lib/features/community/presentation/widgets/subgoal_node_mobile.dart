import 'package:flutter/material.dart';
import 'package:roadmap_ai/core/common/entities/subgoal.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:url_launcher/url_launcher.dart';

/// Mobile-optimized subgoal node with card layout
class SubgoalNodeMobile extends StatelessWidget {
  const SubgoalNodeMobile({
    super.key,
    required this.subgoal,
    required this.index,
    required this.isExpanded,
    required this.onToggle,
  });

  final Subgoal subgoal;
  final int index;
  final bool isExpanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;

    return Card(
      margin: EdgeInsets.only(bottom: 8, left: 8),
      color: colorScheme.surface,
      elevation: 2,
      child: InkWell(
        onTap: onToggle,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row
              Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: colorScheme.primary.withAlpha(51),
                    child: Text(
                      '${index + 1}',
                      style: textTheme.labelSmall?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      subgoal.title,
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    size: 20,
                    color: colorScheme.primary,
                  ),
                ],
              ),
              // Duration chip
              if (subgoal.duration.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(top: 8, left: 28),
                  child: Chip(
                    labelPadding: EdgeInsets.only(right: 8),
                    label: Text(subgoal.duration, style: textTheme.labelSmall),
                    avatar: Icon(Icons.schedule, size: 16),
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                  ),
                ),
              // Expanded content
              if (isExpanded) ...[
                SizedBox(height: 8),
                Padding(
                  padding: EdgeInsets.only(left: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Description
                      if (subgoal.description.isNotEmpty) ...[
                        Text(subgoal.description, style: textTheme.bodySmall),
                        SizedBox(height: 8),
                      ],
                      // Resources
                      if (subgoal.resources.isNotEmpty) ...[
                        Text(
                          'Resources:',
                          style: textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        ...subgoal.resources.map(
                          (resource) => _buildResourceItem(
                            resource,
                            textTheme,
                            colorScheme,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResourceItem(
    String resource,
    TextTheme textTheme,
    ColorScheme colorScheme,
  ) {
    if (!resource.contains('http')) {
      return Padding(
        padding: EdgeInsets.only(bottom: 4),
        child: Text("- $resource", style: textTheme.bodySmall),
      );
    }

    // Extract URL
    String url = resource;
    if (resource.contains("https")) {
      url = resource.substring(resource.indexOf("https"));
    } else if (resource.contains("http")) {
      url = resource.substring(resource.indexOf("http"));
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.link, size: 14, color: colorScheme.primary),
          SizedBox(width: 4),
          Expanded(
            child: InkWell(
              onTap: () async {
                final uri = Uri.parse(url);
                await launchUrl(uri);
              },
              child: Text(
                url,
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.primary,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
