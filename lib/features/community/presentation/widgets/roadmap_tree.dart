import 'package:flutter/material.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/core/common/entities/goal.dart';
import 'package:roadmap_ai/core/common/entities/roadmap.dart';
import 'package:roadmap_ai/core/common/entities/subgoal.dart';
import 'package:roadmap_ai/features/community/presentation/widgets/subgoal_card.dart';

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
    _expandedGoalIndexes = List.generate(
      widget.roadmap.goals.length,
      (index) => index,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
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
            child: GoalNode(
              index: index,
              haveDivider: index < widget.roadmap.goals.length - 1,
              goal: widget.roadmap.goals[index],
              isExpanded: _expandedGoalIndexes.contains(index),
            ),
          ),
        );
      },
    );
  }
}

class GoalNode extends StatefulWidget {
  const GoalNode({
    super.key,
    required this.goal,
    required this.index,
    this.haveDivider = true,
    this.isExpanded = true,
  });
  final Goal goal;
  final int index;
  final bool haveDivider;
  final bool isExpanded;

  @override
  State<GoalNode> createState() => _GoalNodeState();
}

class _GoalNodeState extends State<GoalNode> {
  // List to track expanded state of subgoals
  final List<int> _expandedSubgoalsIndexes = [];

  // Constants for divider and spacing calculations
  static const double kDefaultDividerHeight = 60.0; // Increased from 50.0
  static const double kExpandedDividerExtraHeight =
      200.0; // Increased from 10.0
  static const double kCollapsedDividerHeight = 70.0; // Increased from 60.0
  static const double kDividerVerticalMargin = 0.0; // Reduced from 5.0

  // Calculate the required divider height based on subgoals
  double _calculateDividerHeight() {
    if (!widget.isExpanded || widget.goal.subgoals.isEmpty) {
      return kDefaultDividerHeight;
    }

    double totalHeight = 0;

    // Calculate height for each subgoal dynamically
    for (int i = 0; i < widget.goal.subgoals.length; i++) {
      // Base collapsed height for each subgoal
      double subgoalHeight = 90; // kCollapsedHeight from subgoal node

      // Add expanded height if this subgoal is expanded
      if (_expandedSubgoalsIndexes.contains(i)) {
        subgoalHeight += 90; // kExpandedExtraHeight

        // Add height for resources if present
        final subgoal = widget.goal.subgoals[i];
        if (subgoal.resources.isNotEmpty) {
          subgoalHeight += (subgoal.resources.length * 20);
        }
      }
      totalHeight += subgoalHeight;
    }
    return totalHeight;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenWidth;
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize:
                  MainAxisSize.min, // Ensure column takes minimal space
              children: [
                CircleAvatar(
                  backgroundColor: colorScheme.primary.withAlpha(38),
                  child: Text(
                    '${widget.index + 1}',
                    style: TextStyle(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (widget.haveDivider)
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: kDividerVerticalMargin,
                    ),
                    height: widget.isExpanded
                        ? _calculateDividerHeight() +
                              kExpandedDividerExtraHeight
                        : kCollapsedDividerHeight, // Added extra height to ensure connection
                    child: VerticalDivider(
                      color: Colors.grey.withAlpha(128),
                      thickness: 1.5,
                    ),
                  ),
              ],
            ),
            SizedBox(width: screenWidth * 0.02),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.goal.title,
                          style: textTheme.titleMedium!.copyWith(
                            color: colorScheme.primaryContainer,
                            decoration: TextDecoration.underline,
                            decorationColor: colorScheme.primaryContainer,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        // Replace the Column in your RoadmapTree GoalNode with this:
                        if (widget.isExpanded &&
                            widget.goal.subgoals.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(left: 40, top: 20),
                            child: Column(
                              spacing: 10,
                              children: [
                                // Remove the spacing: 10 property
                                // Remove the empty SizedBox() at the beginning
                                SizedBox(),
                                for (
                                  int i = 0;
                                  i < widget.goal.subgoals.length;
                                  i++
                                )
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (_expandedSubgoalsIndexes.contains(
                                          i,
                                        )) {
                                          _expandedSubgoalsIndexes.remove(i);
                                        } else {
                                          _expandedSubgoalsIndexes.add(i);
                                        }
                                      });
                                    },
                                    child: SubgoalNode(
                                      subgoal: widget.goal.subgoals[i],
                                      index: i,
                                      isLast:
                                          i == widget.goal.subgoals.length - 1,
                                      isExpanded: _expandedSubgoalsIndexes
                                          .contains(i),
                                    ),
                                  ),
                                // Remove the conditional SizedBox at the end entirely
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 150),
                    child: widget.isExpanded
                        ? Icon(
                            Icons.expand_less,
                            key: ValueKey('less'),
                            color: colorScheme.primary,
                          )
                        : Icon(
                            Icons.expand_more,
                            key: ValueKey('more'),
                            color: colorScheme.primary,
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SubgoalNode extends StatefulWidget {
  const SubgoalNode({
    super.key,
    required this.subgoal,
    required this.index,
    this.isLast = false,
    this.isExpanded = false,
  });

  final Subgoal subgoal;
  final int index;
  final bool isLast;
  final bool isExpanded;

  @override
  State<SubgoalNode> createState() => _SubgoalNodeState();
}

class _SubgoalNodeState extends State<SubgoalNode> {
  // Constants for divider and spacing calculations
  static const double kCollapsedHeight = 80.0;
  static const double kExpandedExtraHeight = 80.0;
  static const double kCardPadding = 15.0;
  static const double kResourceBaseHeight = 20.0;
  static const double kResourceItemHeight = 20.0;
  static const double kStatusHeight = 25.0;

  // Calculate divider height based on expansion state
  double _calculateDividerHeight() {
    // Base heights for expanded and collapsed states

    // If expanded, add extra height based on content
    double totalHeight = kCollapsedHeight;

    if (widget.isExpanded) {
      // Add additional height for expanded content
      totalHeight += kExpandedExtraHeight;

      // Add height for resources if present
      if (widget.subgoal.resources.isNotEmpty) {
        totalHeight +=
            kResourceBaseHeight +
            (widget.subgoal.resources.length * kResourceItemHeight);
      }

      // Add height for status if present
      if (widget.subgoal.status != null) {
        totalHeight += kStatusHeight;
      }
    }

    // Add padding to ensure smooth connection
    return totalHeight + kCardPadding;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 20,
          child: Column(
            children: [
              CircleAvatar(
                radius: 10,
                backgroundColor: colorScheme.secondary.withAlpha(38),
                child: Text(
                  '${widget.index + 1}',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Vertical divider - extends to next subgoal
              if (!widget.isLast)
                AnimatedContainer(
                  duration: Duration(milliseconds: 150),
                  width: 2,
                  height: _calculateDividerHeight(),
                  color: Colors.grey.withAlpha(77),
                ),
            ],
          ),
        ),

        // Horizontal connector from parent with subtle gradient
        Container(
          width: 20,
          height: 20,
          alignment: Alignment.centerLeft,
          child: Container(
            height: 2,
            width: 20,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey.withAlpha(128), Colors.grey.withAlpha(77)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
        ),

        Expanded(
          child: SubgoalCard(
            isExpanded: widget.isExpanded,
            subgoal: widget.subgoal,
          ),
        ),
      ],
    );
  }
}
