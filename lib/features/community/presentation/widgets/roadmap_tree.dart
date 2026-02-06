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
    // Mobile layout
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      return _buildMobileLayout();
    }

    // Web/Desktop layout
    return _buildWebLayout();
  }

  Widget _buildMobileLayout() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(16),
      itemCount: widget.roadmap.goals.length,
      itemBuilder: (context, index) => GoalNodeMobile(
        key: ValueKey(widget.roadmap.goals[index].id),
        goal: widget.roadmap.goals[index],
        index: index,
        isExpanded: _expandedGoalIndexes.contains(index),
        onToggle: () {
          setState(() {
            if (_expandedGoalIndexes.contains(index)) {
              _expandedGoalIndexes.remove(index);
            } else {
              _expandedGoalIndexes.add(index);
            }
          });
        },
      ),
    );
  }

  Widget _buildWebLayout() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      itemCount: widget.roadmap.goals.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: GestureDetector(
            onTap: () {
              setState(() {
                if (_expandedGoalIndexes.contains(index)) {
                  _expandedGoalIndexes.remove(index);
                } else {
                  _expandedGoalIndexes.add(index);
                }
              });
            },
            child: GoalNodeWeb(
              goal: widget.roadmap.goals[index],
              index: index,
              haveDivider: index < widget.roadmap.goals.length - 1,
              isExpanded: _expandedGoalIndexes.contains(index),
              onToggle: () {
                setState(() {
                  if (_expandedGoalIndexes.contains(index)) {
                    _expandedGoalIndexes.remove(index);
                  } else {
                    _expandedGoalIndexes.add(index);
                  }
                });
              },
            ),
          ),
        );
      },
    );
  }
}
