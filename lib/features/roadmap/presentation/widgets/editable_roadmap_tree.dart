import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadmap_ai/core/common/entities/goal.dart';
import 'package:roadmap_ai/core/common/entities/roadmap.dart';
import 'package:roadmap_ai/core/common/entities/subgoal.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/features/community/presentation/providers/create_post/create_post_notifier.dart';
import 'package:roadmap_ai/features/roadmap/presentation/widgets/add_goal_dialog.dart';
import 'package:roadmap_ai/features/roadmap/presentation/widgets/add_subgoal_dialog.dart';
import 'package:roadmap_ai/features/roadmap/presentation/widgets/edit_goal_dialog.dart';
import 'package:roadmap_ai/features/roadmap/presentation/widgets/editable_subgoal_card.dart';

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
  List<int> _expandedGoalsIndexes = [];

  @override
  void initState() {
    _expandedGoalsIndexes = List.generate(
      widget.roadmap.goals.length,
      (index) => index,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Get the CreatePostNotifier if we're in customizable mode
    final notifier = widget.isCustomizable
        ? ref.read(createPostNotifierProvider(widget.roadmap.id).notifier)
        : null;

    if (widget.shrinkWrap) {
      // For use in scrollable contexts like CustomScrollView
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            itemCount: widget.roadmap.goals.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (_expandedGoalsIndexes.contains(index)) {
                      _expandedGoalsIndexes.remove(index);
                    } else {
                      _expandedGoalsIndexes.add(index);
                    }
                  });
                },
                child: EditableGoalNode(
                  isExpanded: _expandedGoalsIndexes.contains(index),
                  key: ValueKey(widget.roadmap.goals[index].id),
                  index: index,
                  roadmapId: widget.roadmap.id,
                  haveDivider: index < widget.roadmap.goals.length - 1,
                  goal: widget.roadmap.goals[index],
                  isProgressEditable: widget.isProgressEditable,
                  isCustomizable: widget.isCustomizable,
                ),
              );
            },
          ),
          if (widget.isCustomizable)
            Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    if (notifier != null) {
                      showDialog(
                        context: context,
                        builder: (context) => AddGoalDialog(
                          onSave: (title) {
                            notifier.addNewGoal(title);
                          },
                        ),
                      );
                    } else {
                      // TODO: Add goal functionality for roadmap view
                      print('Add new goal - roadmap view');
                    }
                  },
                  icon: Icon(Icons.add),
                  label: Text('Add Goal'),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ),
        ],
      );
    }
    // For use in regular contexts with Expanded
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            itemCount: widget.roadmap.goals.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (_expandedGoalsIndexes.contains(index)) {
                      _expandedGoalsIndexes.remove(index);
                    } else {
                      _expandedGoalsIndexes.add(index);
                    }
                  });
                },
                child: EditableGoalNode(
                  isExpanded: _expandedGoalsIndexes.contains(index),
                  key: ValueKey(widget.roadmap.goals[index].id),
                  index: index,
                  roadmapId: widget.roadmap.id,
                  haveDivider: index < widget.roadmap.goals.length - 1,
                  goal: widget.roadmap.goals[index],
                  isProgressEditable: widget.isProgressEditable,
                  isCustomizable: widget.isCustomizable,
                ),
              );
            },
          ),
        ),
        if (widget.isCustomizable)
          Padding(
            padding: EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  if (notifier != null) {
                    showDialog(
                      context: context,
                      builder: (context) => AddGoalDialog(
                        onSave: (title) {
                          notifier.addNewGoal(title);
                        },
                      ),
                    );
                  } else {
                    // TODO: Add goal functionality for roadmap view
                    print('Add new goal - roadmap view');
                  }
                },
                icon: Icon(Icons.add),
                label: Text('Add Goal'),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class EditableGoalNode extends ConsumerStatefulWidget {
  const EditableGoalNode({
    super.key,
    required this.goal,
    required this.roadmapId,
    required this.index,
    this.haveDivider = true,
    this.isProgressEditable = false,
    this.isCustomizable = false,
    required this.isExpanded,
  });

  final bool isExpanded;
  final Goal goal;
  final String roadmapId;
  final int index;
  final bool haveDivider;
  final bool isProgressEditable;
  final bool isCustomizable;

  @override
  ConsumerState<EditableGoalNode> createState() => _EditableGoalNodeState();
}

class _EditableGoalNodeState extends ConsumerState<EditableGoalNode> {
  // List to track expanded state of subgoals
  final List<int> _expandedSubgoalsIndexes = [];

  // Constants for divider and spacing calculations
  static const double kDefaultDividerHeight = 60.0; // Increased from 50.0
  static const double kExpandedDividerExtraHeight =
      200.0; // Increased from 10.0
  static const double kCollapsedDividerHeight = 70.0; // Increased from 60.0
  static const double kDividerVerticalMargin = 0.0; // Reduced from 5.0
  static const double kSubgoalBottomSpacing = 25.0; // Increased from 20.0

  // Calculate the required divider height based on subgoals
  double _calculateDividerHeight() {
    if (!widget.isExpanded || widget.goal.subgoals.isEmpty) {
      return kDefaultDividerHeight;
    }

    double totalHeight = 0;

    // Add height for the goal title and its spacing
    totalHeight += 40; // Goal title height and spacing

    // Add top padding from the subgoals container
    totalHeight += 20; // top padding

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
          subgoalHeight += 20 + (subgoal.resources.length * 20);
        }

        // Add height for status if present
        if (subgoal.status != null) {
          subgoalHeight += 25;
        }
      }

      // Add card padding and connection padding
      subgoalHeight += 25; // 15 (card padding) + 10 (extra connection padding)

      totalHeight += subgoalHeight;

      // Add spacing between subgoals (10px margin from AnimatedContainer)
      if (i < widget.goal.subgoals.length - 1) {
        totalHeight += 10;
      }
    }

    // Add the extra bottom spacing
    totalHeight += kSubgoalBottomSpacing + 10;

    // Add some buffer to ensure complete connection
    return totalHeight + 10;
  }

  @override
  Widget build(BuildContext context) {
    // Get the CreatePostNotifier if we're in customizable mode
    final notifier = widget.isCustomizable
        ? ref.read(createPostNotifierProvider(widget.roadmapId).notifier)
        : null;

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
                        offset: Offset(1, 1),
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
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: kDividerVerticalMargin,
                    ),
                    height: widget.isExpanded
                        ? _calculateDividerHeight() +
                              kExpandedDividerExtraHeight
                        : kCollapsedDividerHeight,
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                widget.goal.title,
                                style: textTheme.titleLarge!.copyWith(
                                  color: colorScheme.primaryContainer,
                                  fontWeight: FontWeight.w900,
                                  decoration: TextDecoration.underline,
                                  decorationColor: colorScheme.primaryContainer,
                                ),
                              ),
                            ),
                            if (widget.isCustomizable) ...[
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => EditGoalDialog(
                                      goal: widget.goal,
                                      onSave: (newTitle) {
                                        if (notifier != null) {
                                          notifier.setGoalTitle(
                                            widget.goal.id,
                                            newTitle,
                                          );
                                        } else {
                                          // TODO: Implement goal edit functionality with roadmap notifier
                                          print(
                                            'Edit goal: ${widget.goal.title} -> $newTitle',
                                          );
                                        }
                                      },
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.edit,
                                  size: 18,
                                  color: colorScheme.primary,
                                ),
                                tooltip: 'Edit Goal',
                              ),
                              IconButton(
                                onPressed: () {
                                  // TODO: Delete goal functionality
                                  print('Delete goal: ${widget.goal.title}');
                                },
                                icon: Icon(
                                  Icons.delete,
                                  size: 18,
                                  color: colorScheme.error,
                                ),
                                tooltip: 'Delete Goal',
                              ),
                            ],
                          ],
                        ),
                        if (widget.isExpanded &&
                            widget.goal.subgoals.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(left: 40, top: 20),
                            child: Column(
                              children: [
                                SizedBox(height: 20),
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
                                    child: EditableSubgoalNode(
                                      key: ValueKey(
                                        '${widget.goal.id}-${widget.goal.subgoals[i].id}',
                                      ),
                                      subgoal: widget.goal.subgoals[i],
                                      goalId: widget.goal.id,
                                      goalIndex: widget.index,
                                      roadmapId: widget.roadmapId,
                                      index: i,
                                      isLast:
                                          i == widget.goal.subgoals.length - 1,
                                      isProgressEditable:
                                          widget.isProgressEditable,
                                      isCustomizable: widget.isCustomizable,
                                      isExpanded: _expandedSubgoalsIndexes
                                          .contains(i),
                                    ),
                                  ),
                                // Add subgoal button when customizable
                                if (widget.isCustomizable)
                                  Padding(
                                    padding: EdgeInsets.only(left: 20, top: 10),
                                    child: OutlinedButton.icon(
                                      onPressed: () {
                                        print(
                                          'Add Subgoal button pressed - notifier: ${notifier != null ? 'available' : 'null'}',
                                        );
                                        if (notifier != null) {
                                          showDialog(
                                            context: context,
                                            builder: (context) =>
                                                AddSubgoalDialog(
                                                  onSave:
                                                      ({
                                                        required String title,
                                                        required String
                                                        description,
                                                        required String
                                                        duration,
                                                        required List<String>
                                                        resources,
                                                      }) {
                                                        notifier.addNewSubgoal(
                                                          goalId:
                                                              widget.goal.id,
                                                          title: title,
                                                          description:
                                                              description,
                                                          duration: duration,
                                                          resources: resources,
                                                        );
                                                      },
                                                ),
                                          );
                                        } else {
                                          // TODO: Add subgoal functionality for roadmap view
                                          print(
                                            'Add subgoal to goal: ${widget.goal.title}',
                                          );
                                        }
                                      },
                                      icon: Icon(Icons.add, size: 16),
                                      label: Text('Add Subgoal'),
                                      style: OutlinedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                        textStyle: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ),
                                // Add additional space after the last subgoal
                                SizedBox(
                                  height: kSubgoalBottomSpacing + 10,
                                ), // Extra spacing after the last subgoal
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

class EditableSubgoalNode extends ConsumerStatefulWidget {
  const EditableSubgoalNode({
    super.key,
    required this.subgoal,
    required this.goalId,
    required this.goalIndex,
    required this.roadmapId,
    required this.index,
    this.isLast = false,
    this.isProgressEditable = false,
    this.isCustomizable = false,
    required this.isExpanded,
  });
  final String roadmapId;
  final Subgoal subgoal;
  final String goalId;
  final int goalIndex;
  final int index;
  final bool isLast;
  final bool isProgressEditable;
  final bool isCustomizable;
  final bool isExpanded;

  @override
  ConsumerState<EditableSubgoalNode> createState() =>
      _EditableSubgoalNodeState();
}

class _EditableSubgoalNodeState extends ConsumerState<EditableSubgoalNode> {
  // Constants for divider and spacing calculations
  static const double kCollapsedHeight = 120.0; // Increased from 80.0
  static const double kExpandedExtraHeight = 90.0; // Increased from 80.0
  static const double kCardPadding = 15.0;
  static const double kResourceBaseHeight = 20.0;
  static const double kResourceItemHeight = 20.0;
  static const double kStatusHeight = 25.0;

  // Calculate divider height based on expansion state
  double _calculateDividerHeight() {
    // Base heights for expanded and collapsed states
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
    return totalHeight +
        kCardPadding +
        10; // Added extra 10px for better connection
  }

  @override
  Widget build(BuildContext context) {
    // Get the CreatePostNotifier if we're in customizable mode

    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: colorScheme.primary,
                  child: Text(
                    '${widget.index + 1}',
                    style: textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              // Vertical divider - extends to next subgoal
              if (!widget.isLast)
                AnimatedContainer(
                  duration: Duration(milliseconds: 150),
                  width: 2,
                  height:
                      _calculateDividerHeight() +
                      15, // Added extra 15px for better connection
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
          child: EditableSubgoalCard(
            isExpanded: widget.isExpanded,
            isCustomizable: widget.isCustomizable,
            isProgressEditable: widget.isProgressEditable,
            roadmapId: widget.roadmapId,
            goalId: widget.goalId,
            subgoal: widget.subgoal,
            index: widget.index,
            goalIndex: widget.goalIndex,
          ),
        ),
      ],
    );
  }
}
