import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadmap_ai/core/common/entities/goal.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/features/community/presentation/providers/create_post/create_post_notifier.dart';
import 'package:roadmap_ai/features/roadmap/presentation/widgets/add_subgoal_dialog.dart';
import 'package:roadmap_ai/features/roadmap/presentation/widgets/edit_goal_dialog.dart';
import 'package:roadmap_ai/features/roadmap/presentation/widgets/editable_subgoal_card.dart';

/// Web-optimized goal node with tree layout and connecting lines
class GoalNodeWeb extends ConsumerStatefulWidget {
  const GoalNodeWeb({
    super.key,
    required this.goal,
    required this.roadmapId,
    required this.index,
    required this.isExpanded,
    required this.onToggle,
    this.haveDivider = true,
    this.isProgressEditable = false,
    this.isCustomizable = false,
  });

  final Goal goal;
  final String roadmapId;
  final int index;
  final bool isExpanded;
  final VoidCallback onToggle;
  final bool haveDivider;
  final bool isProgressEditable;
  final bool isCustomizable;

  @override
  ConsumerState<GoalNodeWeb> createState() => _GoalNodeWebState();
}

class _GoalNodeWebState extends ConsumerState<GoalNodeWeb> {
  final List<int> _expandedSubgoals = [];

  double _calculateDividerHeight() {
    if (!widget.isExpanded || widget.goal.subgoals.isEmpty) {
      return 60.0;
    }

    double height = 60.0;

    for (int i = 0; i < widget.goal.subgoals.length; i++) {
      height += 120.0; // Base subgoal height
      if (_expandedSubgoals.contains(i)) {
        height += 100.0; // Expanded extra
        final subgoal = widget.goal.subgoals[i];
        if (subgoal.resources.isNotEmpty) {
          height += 20.0 + (subgoal.resources.length * 20.0);
        }
      }
    }

    return height + 50.0;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenWidth;
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    final notifier = widget.isCustomizable
        ? ref.read(createPostProvider(widget.roadmapId).notifier)
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Number badge and divider column
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.primary,
                        blurRadius: 10,
                        spreadRadius: 3,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundColor: colorScheme.primary,
                    child: Text(
                      '${widget.index + 1}',
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                if (widget.haveDivider)
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height: widget.isExpanded
                        ? _calculateDividerHeight()
                        : 70.0,
                    child: VerticalDivider(
                      color: Colors.grey.withAlpha(128),
                      thickness: 1.5,
                    ),
                  ),
              ],
            ),
            SizedBox(width: screenWidth * 0.02),
            // Goal content
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Goal header
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.goal.title,
                                style: textTheme.titleLarge?.copyWith(
                                  color: colorScheme.primaryContainer,
                                  fontWeight: FontWeight.w900,
                                  decoration: TextDecoration.underline,
                                  decorationColor: colorScheme.primaryContainer,
                                ),
                              ),
                            ),
                            if (widget.isCustomizable) ...[
                              IconButton(
                                icon: Icon(Icons.edit, size: 18),
                                color: colorScheme.primary,
                                onPressed: () => _showEditDialog(notifier),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, size: 18),
                                color: colorScheme.error,
                                onPressed: () =>
                                    _showDeleteConfirmation(notifier),
                              ),
                            ],
                          ],
                        ),
                        // Subgoals
                        if (widget.isExpanded &&
                            widget.goal.subgoals.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(left: 40, top: 20),
                            child: Column(
                              children: [
                                ...List.generate(
                                  widget.goal.subgoals.length,
                                  (i) => Animate(
                                    effects: [
                                      FadeEffect(
                                        duration: Duration(milliseconds: 400),
                                        delay: Duration(milliseconds: 200 * i),
                                      ),
                                    ],
                                    child: _SubgoalRow(
                                      key: ValueKey(widget.goal.subgoals[i].id),
                                      subgoal: widget.goal.subgoals[i],
                                      goalId: widget.goal.id,
                                      roadmapId: widget.roadmapId,
                                      index: i,
                                      goalIndex: widget.index,
                                      isLast:
                                          i == widget.goal.subgoals.length - 1,
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
                                      isProgressEditable:
                                          widget.isProgressEditable,
                                      isCustomizable: widget.isCustomizable,
                                    ),
                                  ),
                                ),
                                if (widget.isCustomizable)
                                  Padding(
                                    padding: EdgeInsets.only(left: 20, top: 10),
                                    child: FilledButton.icon(
                                      onPressed: () =>
                                          _showAddSubgoalDialog(notifier),
                                      icon: Icon(Icons.add, size: 16),
                                      label: Text('Add Subgoal'),
                                      style: FilledButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  // Expand/collapse icon
                  IconButton(
                    icon: Icon(
                      widget.isExpanded ? Icons.expand_less : Icons.expand_more,
                      size: 40,
                      color: colorScheme.primary,
                    ),
                    onPressed: widget.onToggle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showEditDialog(dynamic notifier) {
    showDialog(
      context: context,
      builder: (context) => EditGoalDialog(
        goal: widget.goal,
        onSave: (newTitle) => notifier?.setGoalTitle(widget.goal.id, newTitle),
      ),
    );
  }

  void _showDeleteConfirmation(dynamic notifier) {
    // TODO: Implement delete confirmation
  }

  void _showAddSubgoalDialog(dynamic notifier) {
    showDialog(
      context: context,
      builder: (context) => AddSubgoalDialog(
        onSave:
            ({
              required String title,
              required String description,
              required String duration,
              required List<String> resources,
            }) {
              notifier?.addNewSubgoal(
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

/// Internal widget for subgoal row with connecting lines
class _SubgoalRow extends ConsumerWidget {
  const _SubgoalRow({
    super.key,
    required this.subgoal,
    required this.goalId,
    required this.roadmapId,
    required this.index,
    required this.goalIndex,
    required this.isLast,
    required this.isExpanded,
    required this.onToggle,
    required this.isProgressEditable,
    required this.isCustomizable,
  });

  final dynamic subgoal;
  final String goalId;
  final String roadmapId;
  final int index;
  final int goalIndex;
  final bool isLast;
  final bool isExpanded;
  final VoidCallback onToggle;
  final bool isProgressEditable;
  final bool isCustomizable;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Connection column
        SizedBox(
          width: 20,
          child: Column(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.primary,
                      blurRadius: 10,
                      spreadRadius: 3,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: colorScheme.primary,
                  child: Text(
                    '${index + 1}',
                    style: textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              if (!isLast)
                AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  width: 2,
                  height: isExpanded ? 180.0 : 120.0,
                  color: Colors.grey.withAlpha(77),
                ),
            ],
          ),
        ),
        // Horizontal connector
        Container(
          width: 20,
          height: 20,
          alignment: Alignment.centerLeft,
          child: Container(
            height: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey.withAlpha(128), Colors.grey.withAlpha(77)],
              ),
            ),
          ),
        ),
        // Subgoal card
        Expanded(
          child: GestureDetector(
            onTap: onToggle,
            child: EditableSubgoalCard(
              isExpanded: isExpanded,
              isCustomizable: isCustomizable,
              isProgressEditable: isProgressEditable,
              roadmapId: roadmapId,
              goalId: goalId,
              subgoal: subgoal,
              index: index,
              goalIndex: goalIndex,
            ),
          ),
        ),
      ],
    );
  }
}
