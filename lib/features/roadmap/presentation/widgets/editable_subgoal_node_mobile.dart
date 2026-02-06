import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadmap_ai/core/common/entities/subgoal.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/features/roadmap/presentation/providers/roadmap_view/roadmap_view_notifier.dart';
import 'package:url_launcher/url_launcher.dart';

/// Mobile-optimized subgoal node with card layout
class EditableSubgoalNodeMobile extends ConsumerWidget {
  const EditableSubgoalNodeMobile({
    super.key,
    required this.subgoal,
    required this.goalId,
    required this.roadmapId,
    required this.index,
    required this.isExpanded,
    required this.onToggle,
    this.isProgressEditable = false,
    this.isCustomizable = false,
    required this.goalIndex,
  });

  final Subgoal subgoal;
  final String goalId;
  final String roadmapId;
  final int index;
  final int goalIndex;
  final bool isExpanded;
  final VoidCallback onToggle;
  final bool isProgressEditable;
  final bool isCustomizable;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;

    final notifier = isProgressEditable
        ? ref.read(roadmapViewProvider(roadmapId).notifier)
        : null;

    return Card(
      margin: EdgeInsets.only(bottom: 8, left: 8),
      color: colorScheme.surface,
      elevation: 10,
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
                  if (isCustomizable)
                    PopupMenuButton(
                      icon: Icon(Icons.more_vert, size: 20),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Row(
                            children: [
                              Icon(Icons.edit, size: 18),
                              SizedBox(width: 8),
                              Text('Edit'),
                            ],
                          ),
                          onTap: () {
                            // TODO: Edit subgoal
                          },
                        ),
                        PopupMenuItem(
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete,
                                size: 18,
                                color: colorScheme.error,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Delete',
                                style: TextStyle(color: colorScheme.error),
                              ),
                            ],
                          ),
                          onTap: () {
                            // TODO: Delete subgoal
                          },
                        ),
                      ],
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
                          (resource) => Padding(
                            padding: EdgeInsets.only(bottom: 4),
                            child: InkWell(
                              onTap: () => _launchUrl(resource),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.link,
                                    size: 14,
                                    color: colorScheme.primary,
                                  ),
                                  SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      resource,
                                      style: textTheme.bodySmall?.copyWith(
                                        color: colorScheme.primary,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                      ],
                      // Status/Progress
                      if (isProgressEditable && subgoal.status != null) ...[
                        Row(
                          children: [
                            Checkbox(
                              value: subgoal.status?.completed,
                              onChanged: (value) {
                                notifier?.updateSubgoalStatus(
                                  goalIndex: goalIndex,
                                  subgoalIndex: index,
                                  goalId: goalId,
                                  subgoalId: subgoal.id,
                                  isCompleted: value ?? false,
                                );
                              },
                            ),
                            Text(
                              subgoal.status != null &&
                                      subgoal.status!.completed
                                  ? 'Completed'
                                  : 'In Progress',
                              style: textTheme.bodySmall,
                            ),
                          ],
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

  Future<void> _launchUrl(String url) async {
    final parsedUrl = url.substring(url.indexOf("https"));
    debugPrint("PARSED: $parsedUrl");
    final uri = Uri.parse(parsedUrl);

    await launchUrl(uri);
  }
}
