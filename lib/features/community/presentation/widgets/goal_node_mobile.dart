import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:roadmap_ai/core/common/entities/goal.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/features/community/presentation/widgets/subgoal_node_mobile.dart';

/// Mobile-optimized goal node with card-based layout
class GoalNodeMobile extends StatefulWidget {
  const GoalNodeMobile({
    super.key,
    required this.goal,
    required this.index,
    required this.isExpanded,
    required this.onToggle,
  });

  final Goal goal;
  final int index;
  final bool isExpanded;
  final VoidCallback onToggle;

  @override
  State<GoalNodeMobile> createState() => _GoalNodeMobileState();
}

class _GoalNodeMobileState extends State<GoalNodeMobile> {
  final List<int> _expandedSubgoals = [];

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;

    return Card(
      color: colorScheme.primaryContainer,
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          // Goal header
          InkWell(
            onTap: widget.onToggle,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  // Goal number badge
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: colorScheme.primary,
                    child: Text(
                      '${widget.index + 1}',
                      style: textTheme.labelLarge?.copyWith(
                        color: colorScheme.primaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  // Goal title
                  Expanded(
                    child: Text(
                      widget.goal.title,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                  // Expand icon
                  Icon(
                    widget.isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: colorScheme.primary,
                  ),
                ],
              ),
            ),
          ),
          // Subgoals list
          if (widget.isExpanded) ...[
            Divider(height: 1, color: colorScheme.primary.withAlpha(51)),
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.goal.subgoals.isEmpty)
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'No subgoals yet',
                        style: textTheme.bodyMedium?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    )
                  else
                    ...widget.goal.subgoals.asMap().entries.map(
                      (entry) => Animate(
                        effects: [
                          FadeEffect(
                            duration: Durations.long1,
                            delay: Duration(
                              milliseconds: 100 * (entry.key + 1),
                            ),
                          ),
                        ],
                        child: SubgoalNodeMobile(
                          subgoal: entry.value,
                          index: entry.key,
                          isExpanded: _expandedSubgoals.contains(entry.key),
                          onToggle: () {
                            setState(() {
                              if (_expandedSubgoals.contains(entry.key)) {
                                _expandedSubgoals.remove(entry.key);
                              } else {
                                _expandedSubgoals.add(entry.key);
                              }
                            });
                          },
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
