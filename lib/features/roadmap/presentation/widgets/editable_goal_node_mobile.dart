import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:roadmap_ai/core/common/entities/goal.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/features/community/presentation/providers/create_post/create_post_notifier.dart';
import 'package:roadmap_ai/features/roadmap/presentation/widgets/add_subgoal_bottom_sheet.dart';
import 'package:roadmap_ai/features/roadmap/presentation/widgets/edit_goal_dialog.dart';
import 'package:roadmap_ai/features/roadmap/presentation/widgets/editable_subgoal_node_mobile.dart';

class EditableGoalNodeMobile extends ConsumerStatefulWidget {
  const EditableGoalNodeMobile({
    super.key,
    required this.goal,
    required this.roadmapId,
    required this.index,
    required this.isExpanded,
    required this.onToggle,
    this.isProgressEditable = false,
    this.isCustomizable = false,
  });

  final Goal goal;
  final String roadmapId;
  final int index;
  final bool isExpanded;
  final VoidCallback onToggle;
  final bool isProgressEditable;
  final bool isCustomizable;

  @override
  ConsumerState<EditableGoalNodeMobile> createState() => _GoalNodeMobileState();
}

class _GoalNodeMobileState extends ConsumerState<EditableGoalNodeMobile> {
  final List<int> _expandedSubgoals = [];

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;
    final notifier = widget.isCustomizable
        ? ref.read(createPostProvider(widget.roadmapId).notifier)
        : null;

    return Card(
      color: colorScheme.primaryContainer,
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          // Goal header
          InkWell(
            onTap: widget.onToggle,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  // Goal number badge
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: colorScheme.primary,
                    child: Text(
                      '${widget.index + 1}',
                      style: textTheme.labelLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  // Goal title
                  Expanded(
                    child: Text(
                      widget.goal.title,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                  // Actions
                  if (widget.isCustomizable) ...[
                    IconButton(
                      icon: Icon(Icons.edit, size: 20),
                      color: colorScheme.primary,
                      onPressed: () => _showEditDialog(notifier),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, size: 20),
                      color: colorScheme.error,
                      onPressed: () =>
                          _showRemoveGoalConfirmation(notifier, widget.goal.id),
                    ),
                  ],
                  // Expand icon
                  Icon(
                    widget.isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: colorScheme.primary,
                  ),
                ],
              ),
            ),
          ),
          // Subgoals list
          if (widget.isExpanded) ...[
            Divider(height: 5, color: colorScheme.secondary),
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.goal.subgoals.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'No subgoals yet',
                          style: textTheme.bodyMedium,
                        ),
                      ),
                    )
                  else
                    ...List.generate(
                      widget.goal.subgoals.length,
                      (i) => Animate(
                        effects: [
                          FadeEffect(
                            duration: Duration(milliseconds: 300),
                            delay: Duration(milliseconds: 100 * i),
                          ),
                        ],
                        child: EditableSubgoalNodeMobile(
                          key: ValueKey(widget.goal.subgoals[i].id),
                          subgoal: widget.goal.subgoals[i],
                          goalIndex: widget.index,
                          goalId: widget.goal.id,
                          roadmapId: widget.roadmapId,
                          index: i,
                          isExpanded: _expandedSubgoals.contains(i),
                          onToggle: () {
                            setState(() {
                              if (_expandedSubgoals.contains(i)) {
                                _expandedSubgoals.remove(i);
                              } else {
                                _expandedSubgoals.add(i);
                              }
                            });
                          },
                          isProgressEditable: widget.isProgressEditable,
                          isCustomizable: widget.isCustomizable,
                        ),
                      ),
                    ),
                  // Add subgoal button
                  if (widget.isCustomizable)
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () => _showAddSubgoalDialog(notifier),
                          icon: Icon(Icons.add, size: 18),
                          label: Text('Add Subgoal'),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _showEditDialog(CreatePostNotifier? notifier) {
    showDialog(
      context: context,
      builder: (context) => EditGoalDialog(
        goal: widget.goal,
        onSave: (newTitle) {
          notifier?.setGoalTitle(widget.goal.id, newTitle);
        },
      ),
    );
  }

  void _showRemoveGoalConfirmation(
    CreatePostNotifier? notifier,
    String goalId,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Goal'),
        content: Text(
          'Are you sure you want to delete "${widget.goal.title}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              notifier?.removeGoal(goalId);
              context.pop();
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showAddSubgoalDialog(CreatePostNotifier? notifier) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder: (context) => AddSubgoalBottomSheet(
        onSave:
            ({
              required String title,
              required String description,
              required String duration,
              required List<String> resources,
            }) {
              notifier?.addSubgoal(
                goalId: widget.goal.id,
                title: title,
                description: description,
                duration: duration,
                resources: resources,
              );
            },
      ),
    );
  }
}
