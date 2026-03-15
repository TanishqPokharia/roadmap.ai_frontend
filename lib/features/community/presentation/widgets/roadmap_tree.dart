import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:roadmap_ai/core/common/entities/roadmap.dart';
import 'package:roadmap_ai/features/community/presentation/widgets/goal_node_mobile.dart';
import 'package:roadmap_ai/features/community/presentation/widgets/goal_node_web.dart';

/// Main roadmap tree widget with platform-specific rendering
///
/// On mobile: Uses card-based layout for easier touch interaction
/// On web: Uses tree layout with connecting lines for visual hierarchy
class RoadmapTree extends StatefulWidget {
  final Roadmap roadmap;

  const RoadmapTree({required this.roadmap, super.key});

  @override
  State<RoadmapTree> createState() => _RoadmapTreeState();
}

class _RoadmapTreeState extends State<RoadmapTree> {
  List<int> _expandedGoalIndexes = [];

  @override
  void initState() {
    super.initState();
    _expandedGoalIndexes = List.generate(
      widget.roadmap.goals.length,
      (index) => index,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      return _RoadmapTreeMobileLayout(
        roadmap: widget.roadmap,
        expandedGoalIndexes: _expandedGoalIndexes,
        onToggleGoal: _toggleGoal,
      );
    }

    return _RoadmapTreeWebLayout(
      roadmap: widget.roadmap,
      expandedGoalIndexes: _expandedGoalIndexes,
      onToggleGoal: _toggleGoal,
    );
  }

  void _toggleGoal(int index) {
    setState(() {
      if (_expandedGoalIndexes.contains(index)) {
        _expandedGoalIndexes.remove(index);
      } else {
        _expandedGoalIndexes.add(index);
      }
    });
  }
}

class _RoadmapTreeMobileLayout extends StatelessWidget {
  final Roadmap roadmap;
  final List<int> expandedGoalIndexes;
  final ValueChanged<int> onToggleGoal;

  const _RoadmapTreeMobileLayout({
    required this.roadmap,
    required this.expandedGoalIndexes,
    required this.onToggleGoal,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: roadmap.goals.length,
      itemBuilder: (context, index) => GoalNodeMobile(
        key: ValueKey(roadmap.goals[index].id),
        goal: roadmap.goals[index],
        index: index,
        isExpanded: expandedGoalIndexes.contains(index),
        onToggle: () => onToggleGoal(index),
      ),
    );
  }
}

class _RoadmapTreeWebLayout extends StatelessWidget {
  final Roadmap roadmap;
  final List<int> expandedGoalIndexes;
  final ValueChanged<int> onToggleGoal;

  const _RoadmapTreeWebLayout({
    required this.roadmap,
    required this.expandedGoalIndexes,
    required this.onToggleGoal,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      itemCount: roadmap.goals.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: GestureDetector(
            onTap: () => onToggleGoal(index),
            child: GoalNodeWeb(
              goal: roadmap.goals[index],
              index: index,
              haveDivider: index < roadmap.goals.length - 1,
              isExpanded: expandedGoalIndexes.contains(index),
              onToggle: () => onToggleGoal(index),
            ),
          ),
        );
      },
    );
  }
}
