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
    final CreatePostNotifier? notifier = widget.isCustomizable
        ? ref.read(createPostProvider(widget.roadmap.id).notifier)
        : null;
    final isMobile = !kIsWeb && (Platform.isAndroid || Platform.isIOS);

    if (isMobile) {
      return _EditableRoadmapMobileLayout(
        roadmap: widget.roadmap,
        expandedGoals: _expandedGoals,
        shrinkWrap: widget.shrinkWrap,
        isProgressEditable: widget.isProgressEditable,
        isCustomizable: widget.isCustomizable,
        onToggleGoal: _toggleGoal,
        onAddGoal: notifier == null ? null : () => _showAddGoalDialog(notifier),
      );
    }

    return _EditableRoadmapWebLayout(
      roadmap: widget.roadmap,
      expandedGoals: _expandedGoals,
      shrinkWrap: widget.shrinkWrap,
      isProgressEditable: widget.isProgressEditable,
      isCustomizable: widget.isCustomizable,
      onToggleGoal: _toggleGoal,
      onAddGoal: notifier == null ? null : () => _showAddGoalDialog(notifier),
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

  void _showAddGoalDialog(CreatePostNotifier? notifier) {
    if (notifier == null) return;

    showDialog(
      context: context,
      builder: (context) =>
          AddGoalDialog(onSave: (title) => notifier.addGoal(title)),
    );
  }
}

class _EditableRoadmapMobileLayout extends StatelessWidget {
  final Roadmap roadmap;
  final List<int> expandedGoals;
  final bool isProgressEditable;
  final bool isCustomizable;
  final bool shrinkWrap;
  final ValueChanged<int> onToggleGoal;
  final VoidCallback? onAddGoal;

  const _EditableRoadmapMobileLayout({
    required this.roadmap,
    required this.expandedGoals,
    required this.isProgressEditable,
    required this.isCustomizable,
    required this.shrinkWrap,
    required this.onToggleGoal,
    required this.onAddGoal,
  });

  @override
  Widget build(BuildContext context) {
    if (shrinkWrap) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(16),
            itemCount: roadmap.goals.length,
            itemBuilder: (context, index) => EditableGoalNodeMobile(
              key: ValueKey(roadmap.goals[index].id),
              goal: roadmap.goals[index],
              roadmapId: roadmap.id,
              index: index,
              isExpanded: expandedGoals.contains(index),
              onToggle: () => onToggleGoal(index),
              isProgressEditable: isProgressEditable,
              isCustomizable: isCustomizable,
            ),
          ),
          if (isCustomizable && onAddGoal != null)
            _AddGoalButton(onPressed: onAddGoal!),
        ],
      );
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            shrinkWrap: false,
            padding: EdgeInsets.all(16),
            itemCount: roadmap.goals.length,
            itemBuilder: (context, index) => EditableGoalNodeMobile(
              key: ValueKey(roadmap.goals[index].id),
              goal: roadmap.goals[index],
              roadmapId: roadmap.id,
              index: index,
              isExpanded: expandedGoals.contains(index),
              onToggle: () => onToggleGoal(index),
              isProgressEditable: isProgressEditable,
              isCustomizable: isCustomizable,
            ),
          ),
        ),
        if (isCustomizable && onAddGoal != null)
          _AddGoalButton(onPressed: onAddGoal!),
      ],
    );
  }
}

class _EditableRoadmapWebLayout extends StatelessWidget {
  final Roadmap roadmap;
  final List<int> expandedGoals;
  final bool isProgressEditable;
  final bool isCustomizable;
  final bool shrinkWrap;
  final ValueChanged<int> onToggleGoal;
  final VoidCallback? onAddGoal;

  const _EditableRoadmapWebLayout({
    required this.roadmap,
    required this.expandedGoals,
    required this.isProgressEditable,
    required this.isCustomizable,
    required this.shrinkWrap,
    required this.onToggleGoal,
    required this.onAddGoal,
  });

  @override
  Widget build(BuildContext context) {
    if (shrinkWrap) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            itemCount: roadmap.goals.length,
            itemBuilder: (context, index) => GoalNodeWeb(
              key: ValueKey(roadmap.goals[index].id),
              goal: roadmap.goals[index],
              roadmapId: roadmap.id,
              index: index,
              isExpanded: expandedGoals.contains(index),
              onToggle: () => onToggleGoal(index),
              haveDivider: index < roadmap.goals.length - 1,
              isProgressEditable: isProgressEditable,
              isCustomizable: isCustomizable,
            ),
          ),
          if (isCustomizable && onAddGoal != null)
            _AddGoalButton(onPressed: onAddGoal!),
        ],
      );
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            shrinkWrap: false,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            itemCount: roadmap.goals.length,
            itemBuilder: (context, index) => GoalNodeWeb(
              key: ValueKey(roadmap.goals[index].id),
              goal: roadmap.goals[index],
              roadmapId: roadmap.id,
              index: index,
              isExpanded: expandedGoals.contains(index),
              onToggle: () => onToggleGoal(index),
              haveDivider: index < roadmap.goals.length - 1,
              isProgressEditable: isProgressEditable,
              isCustomizable: isCustomizable,
            ),
          ),
        ),
        if (isCustomizable && onAddGoal != null)
          _AddGoalButton(onPressed: onAddGoal!),
      ],
    );
  }
}

class _AddGoalButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _AddGoalButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: FilledButton.icon(
          onPressed: onPressed,
          icon: Icon(Icons.add),
          label: Text('Add Goal'),
          style: FilledButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }
}
