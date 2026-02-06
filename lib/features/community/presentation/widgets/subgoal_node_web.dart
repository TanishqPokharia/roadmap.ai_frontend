import 'package:flutter/material.dart';
import 'package:roadmap_ai/core/common/entities/subgoal.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/features/community/presentation/widgets/subgoal_card.dart';

/// Web-optimized subgoal node with tree layout
class SubgoalNodeWeb extends StatefulWidget {
  const SubgoalNodeWeb({
    super.key,
    required this.subgoal,
    required this.index,
    required this.isLast,
    required this.isExpanded,
    required this.onToggle,
  });

  final Subgoal subgoal;
  final int index;
  final bool isLast;
  final bool isExpanded;
  final VoidCallback onToggle;

  @override
  State<SubgoalNodeWeb> createState() => _SubgoalNodeWebState();
}

class _SubgoalNodeWebState extends State<SubgoalNodeWeb> {
  // Constants for divider calculations
  static const double kCollapsedHeight = 80.0;
  static const double kExpandedExtraHeight = 80.0;
  static const double kCardPadding = 15.0;
  static const double kResourceBaseHeight = 20.0;
  static const double kResourceItemHeight = 20.0;
  static const double kStatusHeight = 25.0;

  double _calculateDividerHeight() {
    double totalHeight = kCollapsedHeight;

    if (widget.isExpanded) {
      totalHeight += kExpandedExtraHeight;

      if (widget.subgoal.resources.isNotEmpty) {
        totalHeight +=
            kResourceBaseHeight +
            (widget.subgoal.resources.length * kResourceItemHeight);
      }

      if (widget.subgoal.status != null) {
        totalHeight += kStatusHeight;
      }
    }

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
          child: GestureDetector(
            onTap: widget.onToggle,
            child: SubgoalCard(
              isExpanded: widget.isExpanded,
              subgoal: widget.subgoal,
            ),
          ),
        ),
      ],
    );
  }
}
