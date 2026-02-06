import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadmap_ai/core/common/entities/roadmap.dart';
import 'package:roadmap_ai/features/community/presentation/providers/create_post/create_post_notifier.dart';
import 'package:roadmap_ai/features/roadmap/presentation/widgets/add_goal_dialog.dart';
import 'package:roadmap_ai/features/roadmap/presentation/widgets/editable_goal_node_mobile.dart';
import 'package:roadmap_ai/features/roadmap/presentation/widgets/goal_node_web.dart';

/// Main roadmap tree widget with platform-specific rendering
///
/// Displays a hierarchical roadmap with goals and subgoals.
/// Supports editing, progress tracking, and customization.
///
/// On mobile: Uses card-based layout for easier touch interaction
/// On web: Uses tree layout with connecting lines for visual hierarchy
class EditableRoadmapTree extends ConsumerStatefulWidget {
  final Roadmap roadmap;
  final bool isProgressEditable;
  final bool isCustomizable;
  final bool shrinkWrap;

  const EditableRoadmapTree({
    required this.roadmap,
    required this.isProgressEditable,
    this.isCustomizable = false,
    this.shrinkWrap = false,
    super.key,
  });

  @override
  ConsumerState<EditableRoadmapTree> createState() =>
      _EditableRoadmapTreeState();
}

class _EditableRoadmapTreeState extends ConsumerState<EditableRoadmapTree> {
  List<int> _expandedGoals = [];

  @override
  void initState() {
    super.initState();
    // Expand all goals by default
    _expandedGoals = List.generate(
      widget.roadmap.goals.length,
      (index) => index,
    );
  }

  @override
  Widget build(BuildContext context) {
    final notifier = widget.isCustomizable
        ? ref.read(createPostProvider(widget.roadmap.id).notifier)
        : null;

    // Mobile layout
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      return _buildMobileLayout(notifier);
    }

    // Web/Desktop layout
    return _buildWebLayout(notifier);
  }

  Widget _buildMobileLayout(dynamic notifier) {
    if (widget.shrinkWrap) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(16),
            itemCount: widget.roadmap.goals.length,
            itemBuilder: (context, index) => EditableGoalNodeMobile(
              key: ValueKey(widget.roadmap.goals[index].id),
              goal: widget.roadmap.goals[index],
              roadmapId: widget.roadmap.id,
              index: index,
              isExpanded: _expandedGoals.contains(index),
              onToggle: () => _toggleGoal(index),
              isProgressEditable: widget.isProgressEditable,
              isCustomizable: widget.isCustomizable,
            ),
          ),
          if (widget.isCustomizable) _buildAddGoalButton(notifier),
        ],
      );
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: widget.roadmap.goals.length,
            itemBuilder: (context, index) => EditableGoalNodeMobile(
              key: ValueKey(widget.roadmap.goals[index].id),
              goal: widget.roadmap.goals[index],
              roadmapId: widget.roadmap.id,
              index: index,
              isExpanded: _expandedGoals.contains(index),
              onToggle: () => _toggleGoal(index),
              isProgressEditable: widget.isProgressEditable,
              isCustomizable: widget.isCustomizable,
            ),
          ),
        ),
        if (widget.isCustomizable) _buildAddGoalButton(notifier),
      ],
    );
  }

  Widget _buildWebLayout(dynamic notifier) {
    if (widget.shrinkWrap) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            itemCount: widget.roadmap.goals.length,
            itemBuilder: (context, index) => GoalNodeWeb(
              key: ValueKey(widget.roadmap.goals[index].id),
              goal: widget.roadmap.goals[index],
              roadmapId: widget.roadmap.id,
              index: index,
              isExpanded: _expandedGoals.contains(index),
              onToggle: () => _toggleGoal(index),
              haveDivider: index < widget.roadmap.goals.length - 1,
              isProgressEditable: widget.isProgressEditable,
              isCustomizable: widget.isCustomizable,
            ),
          ),
          if (widget.isCustomizable) _buildAddGoalButton(notifier),
        ],
      );
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            itemCount: widget.roadmap.goals.length,
            itemBuilder: (context, index) => GoalNodeWeb(
              key: ValueKey(widget.roadmap.goals[index].id),
              goal: widget.roadmap.goals[index],
              roadmapId: widget.roadmap.id,
              index: index,
              isExpanded: _expandedGoals.contains(index),
              onToggle: () => _toggleGoal(index),
              haveDivider: index < widget.roadmap.goals.length - 1,
              isProgressEditable: widget.isProgressEditable,
              isCustomizable: widget.isCustomizable,
            ),
          ),
        ),
        if (widget.isCustomizable) _buildAddGoalButton(notifier),
      ],
    );
  }

  Widget _buildAddGoalButton(dynamic notifier) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: !kIsWeb && (Platform.isAndroid || Platform.isIOS)
            ? FilledButton.icon(
                onPressed: () => _showAddGoalDialog(notifier),
                icon: Icon(Icons.add),
                label: Text('Add Goal'),
                style: FilledButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
              )
            : OutlinedButton.icon(
                onPressed: () => _showAddGoalDialog(notifier),
                icon: Icon(Icons.add),
                label: Text('Add Goal'),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
      ),
    );
  }

  void _toggleGoal(int index) {
    setState(() {
      if (_expandedGoals.contains(index)) {
        _expandedGoals.remove(index);
      } else {
        _expandedGoals.add(index);
      }
    });
  }

  void _showAddGoalDialog(dynamic notifier) {
    if (notifier == null) return;

    showDialog(
      context: context,
      builder: (context) =>
          AddGoalDialog(onSave: (title) => notifier.addNewGoal(title)),
    );
  }
}
