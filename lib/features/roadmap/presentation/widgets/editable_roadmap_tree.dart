import 'package:flutter/material.dart';
import 'package:roadmap_ai/core/common/entities/goal.dart';
import 'package:roadmap_ai/core/common/entities/roadmap.dart';
import 'package:roadmap_ai/core/common/entities/subgoal.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';

class EditableRoadmapTree extends StatefulWidget {
  final Roadmap roadmap;
  final Function(String, String) onToggleCompletion;

  const EditableRoadmapTree({
    required this.roadmap,
    required this.onToggleCompletion,
    super.key,
  });

  @override
  State<EditableRoadmapTree> createState() => _EditableRoadmapTreeState();
}

class _EditableRoadmapTreeState extends State<EditableRoadmapTree> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      itemCount: widget.roadmap.goals.length,
      itemBuilder: (context, index) {
        return EditableGoalNode(
          index: index,
          haveDivider: index < widget.roadmap.goals.length - 1,
          goal: widget.roadmap.goals[index],
          onToggleCompletion: widget.onToggleCompletion,
        );
      },
    );
  }
}

class EditableGoalNode extends StatefulWidget {
  const EditableGoalNode({
    super.key,
    required this.goal,
    required this.index,
    required this.onToggleCompletion,
    this.haveDivider = true,
  });

  final Goal goal;
  final int index;
  final bool haveDivider;
  final Function(String, String) onToggleCompletion;

  @override
  State<EditableGoalNode> createState() => _EditableGoalNodeState();
}

class _EditableGoalNodeState extends State<EditableGoalNode> {
  bool _isExpanded = false;

  // List to track expanded state of subgoals
  List<bool> _expandedSubgoals = [];

  // Constants for divider and spacing calculations
  static const double kDefaultDividerHeight = 60.0; // Increased from 50.0
  static const double kExpandedDividerExtraHeight = 20.0; // Increased from 10.0
  static const double kCollapsedDividerHeight = 70.0; // Increased from 60.0
  static const double kDividerVerticalMargin = 0.0; // Reduced from 5.0
  static const double kSubgoalBottomSpacing = 25.0; // Increased from 20.0

  @override
  void initState() {
    super.initState();
    // Start with expanded state to show all subgoals
    _isExpanded = true;
    if (widget.goal.subgoals.isNotEmpty) {
      _expandedSubgoals = List.generate(
        widget.goal.subgoals.length,
        (_) => false,
      );
    } else {
      _expandedSubgoals = [];
    }
  }

  // Calculate the required divider height based on subgoals
  double _calculateDividerHeight() {
    if (!_isExpanded || widget.goal.subgoals.isEmpty) {
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
      if (i < _expandedSubgoals.length && _expandedSubgoals[i]) {
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
                    height: _isExpanded
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
                        Text(
                          widget.goal.title,
                          style: textTheme.titleMedium!.copyWith(
                            color: colorScheme.primary.withAlpha(204),
                            decoration: TextDecoration.underline,
                            decorationColor: colorScheme.primary.withAlpha(102),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (_isExpanded && widget.goal.subgoals.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(left: 40, top: 20),
                            child: Column(
                              children: [
                                for (
                                  int i = 0;
                                  i < widget.goal.subgoals.length;
                                  i++
                                )
                                  EditableSubgoalNode(
                                    subgoal: widget.goal.subgoals[i],
                                    goalId: widget.goal.id,
                                    index: i,
                                    isLast:
                                        i == widget.goal.subgoals.length - 1,
                                    onToggleCompletion:
                                        widget.onToggleCompletion,
                                    onExpansionChanged: (expanded) {
                                      // Update the expanded state of this subgoal
                                      if (i < _expandedSubgoals.length) {
                                        setState(() {
                                          _expandedSubgoals[i] = expanded;
                                        });
                                      }
                                    },
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
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                    icon: AnimatedSwitcher(
                      duration: Duration(milliseconds: 150),
                      child: _isExpanded
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

class EditableSubgoalNode extends StatefulWidget {
  const EditableSubgoalNode({
    super.key,
    required this.subgoal,
    required this.goalId,
    required this.index,
    required this.onToggleCompletion,
    this.isLast = false,
    this.onExpansionChanged,
  });

  final Subgoal subgoal;
  final String goalId;
  final int index;
  final bool isLast;
  final Function(String, String) onToggleCompletion;
  final Function(bool)? onExpansionChanged;

  @override
  State<EditableSubgoalNode> createState() => _EditableSubgoalNodeState();
}

class _EditableSubgoalNodeState extends State<EditableSubgoalNode> {
  bool _isExpanded = false;

  // Constants for divider and spacing calculations
  static const double kCollapsedHeight = 90.0; // Increased from 80.0
  static const double kExpandedExtraHeight = 90.0; // Increased from 80.0
  static const double kCardPadding = 15.0;
  static const double kResourceBaseHeight = 20.0;
  static const double kResourceItemHeight = 20.0;
  static const double kStatusHeight = 25.0;

  // Calculate divider height based on expansion state
  double _calculateDividerHeight() {
    // Base heights for expanded and collapsed states
    double totalHeight = kCollapsedHeight;

    if (_isExpanded) {
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
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;
    final isCompleted = widget.subgoal.status?.completed ?? false;
    final wasCompletedBefore = widget.subgoal.status?.completedAt != null;

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
          child: InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
                // Notify parent about expansion change
                widget.onExpansionChanged?.call(_isExpanded);
              });
            },
            borderRadius: BorderRadius.circular(8),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 150),
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.withAlpha(26)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(13),
                    blurRadius: 2,
                    offset: Offset(0, 1),
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
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                      if (!wasCompletedBefore) // Only show toggle if not previously completed
                        Transform.scale(
                          scale: 0.8,
                          child: Checkbox(
                            value: isCompleted,
                            activeColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            onChanged: (value) {
                              widget.onToggleCompletion(
                                widget.goalId,
                                widget.subgoal.id,
                              );
                            },
                          ),
                        ),
                      Icon(
                        _isExpanded
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
                        maxLines: _isExpanded ? null : 1,
                        overflow: _isExpanded ? null : TextOverflow.ellipsis,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface.withAlpha(179),
                        ),
                      ),
                    ],
                  ),

                  // Extended content (visible only when expanded)
                  if (_isExpanded) ...[
                    const SizedBox(height: 12),

                    // Resources section
                    if (widget.subgoal.resources.isNotEmpty) ...[
                      Text(
                        'Resources:',
                        style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.secondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      ...widget.subgoal.resources.map(
                        (resource) => Padding(
                          padding: const EdgeInsets.only(bottom: 4, left: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.link,
                                size: 14,
                                color: colorScheme.primary,
                              ),
                              const SizedBox(width: 4),
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
                          border: wasCompletedBefore
                              ? Border.all(color: Colors.grey.withAlpha(100))
                              : widget.subgoal.status!.completedAt == null &&
                                    widget.subgoal.status!.completed
                              ? Border.all(
                                  color: Colors.blue.withAlpha(100),
                                  width: 1.5,
                                )
                              : null,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.subgoal.status!.completed
                                  ? 'Completed'
                                  : 'In Progress',
                              style: textTheme.bodyMedium?.copyWith(
                                color: widget.subgoal.status!.completed
                                    ? Colors.green.shade800
                                    : Colors.orange.shade800,
                              ),
                            ),
                            if (wasCompletedBefore) ...[
                              SizedBox(width: 4),
                              Icon(
                                Icons.lock,
                                size: 12,
                                color: Colors.grey.shade700,
                              ),
                            ],
                            // Show pending indicator if modified but not saved
                            if (!wasCompletedBefore &&
                                widget.subgoal.status!.completed &&
                                widget.subgoal.status!.completedAt == null) ...[
                              SizedBox(width: 4),
                              Icon(
                                Icons.pending,
                                size: 12,
                                color: Colors.blue.shade700,
                              ),
                            ],
                          ],
                        ),
                      ),
                  ],

                  SizedBox(height: 10),

                  // Duration pill (always visible, at bottom)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      widget.subgoal.duration,
                      style: textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSecondaryContainer,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
