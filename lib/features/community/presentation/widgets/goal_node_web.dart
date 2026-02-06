import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:roadmap_ai/core/common/entities/goal.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/features/community/presentation/widgets/subgoal_node_web.dart';

/// Web-optimized goal node with tree layout and connecting lines
class GoalNodeWeb extends StatefulWidget {
  const GoalNodeWeb({
    super.key,
    required this.goal,
    required this.index,
    required this.isExpanded,
    required this.onToggle,
    this.haveDivider = true,
  });

  final Goal goal;
  final int index;
  final bool isExpanded;
  final VoidCallback onToggle;
  final bool haveDivider;

  @override
  State<GoalNodeWeb> createState() => _GoalNodeWebState();
}

class _GoalNodeWebState extends State<GoalNodeWeb> {
  final List<int> _expandedSubgoals = [];

  // Constants for divider calculations
  static const double kDefaultDividerHeight = 60.0;
  static const double kExpandedDividerExtraHeight = 200.0;
  static const double kDividerVerticalMargin = 0.0;

  double _calculateDividerHeight() {
    if (!widget.isExpanded || widget.goal.subgoals.isEmpty) {
      return kDefaultDividerHeight;
    }

    double totalHeight = 0;

    for (int i = 0; i < widget.goal.subgoals.length; i++) {
      double subgoalHeight = 90;

      if (_expandedSubgoals.contains(i)) {
        subgoalHeight += 90;
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
                    height: widget.isExpanded
                        ? _calculateDividerHeight() +
                              kExpandedDividerExtraHeight
                        : 70.0,
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
                        if (widget.isExpanded &&
                            widget.goal.subgoals.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(left: 40, top: 20),
                            child: Column(
                              children: [
                                for (
                                  int i = 0;
                                  i < widget.goal.subgoals.length;
                                  i++
                                )
                                  Animate(
                                    effects: [
                                      FadeEffect(
                                        duration: Durations.long1,
                                        delay: Duration(
                                          milliseconds: 200 * (i + 1),
                                        ),
                                      ),
                                    ],
                                    child: SubgoalNodeWeb(
                                      subgoal: widget.goal.subgoals[i],
                                      index: i,
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
                                    ),
                                  ),
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
