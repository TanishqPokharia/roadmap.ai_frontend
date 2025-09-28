import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadmap_ai/core/common/entities/subgoal.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/core/utils/format_date.dart';
import 'package:roadmap_ai/features/community/presentation/providers/create_post/create_post_notifier.dart';
import 'package:roadmap_ai/features/roadmap/presentation/providers/roadmap_view/roadmap_view_notifier.dart';
import 'package:roadmap_ai/features/roadmap/presentation/widgets/edit_subgoal_dialog.dart';
import 'package:url_launcher/link.dart';

class EditableSubgoalCard extends ConsumerStatefulWidget {
  const EditableSubgoalCard({
    super.key,
    required this.isExpanded,
    required this.subgoal,
    this.isCustomizable = false,
    required this.roadmapId,
    required this.goalId,
    required this.isProgressEditable,
    required this.index,
    required this.goalIndex,
  });

  final bool isExpanded;
  final Subgoal subgoal;
  final bool isCustomizable;
  final String roadmapId;
  final String goalId;
  final bool isProgressEditable;
  final int index;
  final int goalIndex;

  @override
  ConsumerState<EditableSubgoalCard> createState() =>
      _EditableSubgoalCardState();
}

class _EditableSubgoalCardState extends ConsumerState<EditableSubgoalCard> {
  bool _isHoveretd = false;

  @override
  Widget build(BuildContext context) {
    final notifier = widget.isCustomizable
        ? ref.read(createPostNotifierProvider(widget.roadmapId).notifier)
        : null;
    final theme = context.theme;
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHoveretd = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHoveretd = false;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.only(top: 10, bottom: 20, left: 16, right: 16),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            if (_isHoveretd)
              BoxShadow(
                color: colorScheme.primary,
                blurRadius: 10,
                spreadRadius: 5,
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.subgoal.title,
                    style: textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (widget.isCustomizable) ...[
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => EditSubgoalDialog(
                          subgoal: widget.subgoal,
                          onSave: (newTitle, newDescription, newResources) {
                            if (notifier != null) {
                              notifier.setSubgoalDetails(
                                widget.goalId,
                                widget.subgoal.id,
                                newTitle,
                                newDescription,
                                newResources,
                              );
                            } else {
                              // TODO: Implement subgoal edit functionality with roadmap notifier
                              print('Edit subgoal: ${widget.subgoal.title}');
                              print('New title: $newTitle');
                              print('New description: $newDescription');
                              print('New resources: $newResources');
                            }
                          },
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.edit,
                      size: 16,
                      color: colorScheme.primary,
                    ),
                    tooltip: 'Edit Subgoal',
                    constraints: BoxConstraints(minWidth: 32, minHeight: 32),
                  ),
                  IconButton(
                    onPressed: () {
                      // TODO: Delete subgoal functionality
                      print('Delete subgoal: ${widget.subgoal.title}');
                    },
                    icon: Icon(
                      Icons.delete,
                      size: 16,
                      color: colorScheme.error,
                    ),
                    tooltip: 'Delete Subgoal',
                    constraints: BoxConstraints(minWidth: 32, minHeight: 32),
                  ),
                ],
                if (widget.isProgressEditable)
                  Transform.scale(
                    scale: 0.8,
                    child: Checkbox(
                      value: widget.subgoal.status?.completed ?? false,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      onChanged: (value) {
                        if (!context.mounted) {
                          return;
                        }

                        ref
                            .read(
                              roadmapViewNotifierProvider(
                                widget.roadmapId,
                              ).notifier,
                            )
                            .updateSubgoalStatus(
                              goalId: widget.goalId,
                              subgoalId: widget.subgoal.id,
                              goalIndex: widget.goalIndex,
                              subgoalIndex: widget.index,
                              isCompleted: value!,
                            );
                      },
                    ),
                  ),
                Icon(
                  widget.isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  size: 18,
                  color: colorScheme.primary.withAlpha(153),
                ),
              ],
            ),

            // Initial preview (always visible)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                // Description (truncated when not expanded)
                Text(
                  widget.subgoal.description,
                  maxLines: widget.isExpanded ? null : 1,
                  overflow: widget.isExpanded ? null : TextOverflow.ellipsis,
                  style: textTheme.bodyMedium?.copyWith(),
                ),
              ],
            ),

            // Extended content (visible only when expanded)
            if (widget.isExpanded) ...[
              const SizedBox(height: 12),

              // Resources section
              if (widget.subgoal.resources.isNotEmpty) ...[
                Text(
                  'Resources:',
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                ...widget.subgoal.resources.map((resource) {
                  if (!resource.contains('http')) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4, left: 8),
                      child: Text(resource, style: textTheme.bodyMedium),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4, left: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.link,
                          size: textTheme.bodyMedium?.fontSize,
                          color: colorScheme.onPrimary,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Link(
                            uri: Uri.parse(resource),
                            target: LinkTarget.blank,
                            builder: (context, followLink) => GestureDetector(
                              onTap: followLink,
                              child: Text(
                                resource,
                                style: textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.primaryContainer,
                                  decoration: TextDecoration.underline,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 20),
              ],

              // Status section if available
              if (widget.subgoal.status != null)
                Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: widget.subgoal.status!.completed
                        ? Colors.green.withAlpha(26)
                        : Colors.orange.withAlpha(26),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.grey.withAlpha(100)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.subgoal.status!.completed
                            ? ' Completed on ${formatDate(widget.subgoal.status?.completedAt)}'
                            : 'In Progress',
                        style: textTheme.bodyMedium?.copyWith(
                          color: widget.subgoal.status!.completed
                              ? Colors.green.shade800
                              : Colors.orange.shade800,
                        ),
                      ),
                    ],
                  ),
                ),
            ],

            SizedBox(height: 10),

            // Duration pill (always visible, at bottom)
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                widget.subgoal.duration,
                style: textTheme.labelLarge?.copyWith(
                  color: colorScheme.onSecondaryContainer,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
