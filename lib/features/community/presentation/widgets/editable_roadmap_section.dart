import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadmap_ai/core/common/entities/goal.dart';
import 'package:roadmap_ai/core/common/entities/roadmap.dart';
import 'package:roadmap_ai/core/common/entities/subgoal.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/features/community/presentation/providers/edit_roadmap_provider.dart';

class EditableRoadmapSection extends ConsumerStatefulWidget {
  const EditableRoadmapSection({super.key, required this.roadmap});
  final Roadmap roadmap;

  @override
  ConsumerState<EditableRoadmapSection> createState() =>
      _EditableRoadmapSectionState();
}

class _EditableRoadmapSectionState
    extends ConsumerState<EditableRoadmapSection> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = context.screenHeight;
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    // Watch the roadmap for changes
    final editableRoadmapNotifier = editRoadmapNotifierProvider(widget.roadmap);
    final editableRoadmap = ref.watch(editableRoadmapNotifier);
    final notifier = ref.read(editableRoadmapNotifier.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Goals List with indexes
        ...editableRoadmap.goals.asMap().entries.map(
          (entry) => EditableGoalItem(
            key: ValueKey(
              entry.value.id,
            ), // Add key to prevent widget reuse issues
            goal: entry.value,
            index: entry.key + 1, // Using 1-based indexing for display
            notifier: notifier,
          ),
        ),

        // Add Goal Button
        SizedBox(height: 16),
        Center(
          child: OutlinedButton.icon(
            onPressed: () {
              ref.read(editableRoadmapNotifier.notifier).addGoal();
            },
            icon: const Icon(Icons.add),
            label: const Text('Add Goal'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),

        // Empty State
        if (editableRoadmap.goals.isEmpty)
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.05),
              child: Column(
                children: [
                  Icon(
                    Icons.route,
                    size: 64,
                    color: colorScheme.primary.withAlpha(100),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Add goals to your roadmap',
                    style: textTheme.titleMedium!.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'A good roadmap has clear goals and actionable steps',
                    style: textTheme.bodyMedium!.copyWith(
                      color: Colors.grey.shade500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class EditableGoalItem extends ConsumerStatefulWidget {
  final Goal goal;
  final int index;
  final EditRoadmapNotifier notifier;

  const EditableGoalItem({
    super.key,
    required this.goal,
    required this.index,
    required this.notifier,
  });

  @override
  ConsumerState<EditableGoalItem> createState() => _EditableGoalItemState();
}

class _EditableGoalItemState extends ConsumerState<EditableGoalItem> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.screenHeight;
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Goal Header with Title and Actions
            Row(
              children: [
                // Goal Icon with index
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.flag,
                        color: colorScheme.primary,
                        size: 20,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: colorScheme.primaryContainer,
                            width: 2,
                          ),
                        ),
                        child: Text(
                          '${widget.index}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),

                // Goal Title Field
                Expanded(
                  child: TextFormField(
                    initialValue: widget.goal.title,
                    style: textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    minLines: 1,
                    maxLines: null,
                    decoration: const InputDecoration(
                      hintText: 'Goal Title',
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    onChanged: (value) {},
                  ),
                ),

                // Expand/Collapse Button
                IconButton(
                  icon: Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: colorScheme.primary,
                  ),
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                ),

                // Delete Button
                IconButton(
                  icon: Icon(Icons.delete_outline, color: Colors.red.shade300),
                  onPressed: () {
                    // Get the roadmap from the parent provider
                    widget.notifier.removeGoal(widget.goal.id);
                  },
                ),
              ],
            ),

            // Subgoals List (expandable)
            if (_isExpanded) ...[
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),

              // Subgoals Heading
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subgoals',
                    style: textTheme.titleSmall!.copyWith(
                      color: Colors.grey.shade700,
                    ),
                  ),
                  TextButton.icon(
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Add Subgoal'),
                    onPressed: () {
                      // Get the roadmap from the parent provider
                      widget.notifier.addSubgoal(widget.goal.id);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Subgoals List
              ...widget.goal.subgoals.map(
                (subgoal) => EditableSubgoalItem(
                  key: ValueKey(
                    subgoal.id,
                  ), // Add key to prevent widget reuse issues
                  goalId: widget.goal.id,
                  subgoal: subgoal,
                  notifier: widget.notifier,
                ),
              ),

              // Empty Subgoals State
              if (widget.goal.subgoals.isEmpty)
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.02,
                    ),
                    child: Text(
                      'No subgoals yet. Add some steps to achieve this goal.',
                      style: textTheme.bodyMedium!.copyWith(
                        color: Colors.grey.shade500,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

class EditableSubgoalItem extends ConsumerStatefulWidget {
  final String goalId;
  final Subgoal subgoal;
  final EditRoadmapNotifier notifier;

  const EditableSubgoalItem({
    super.key,
    required this.goalId,
    required this.subgoal,
    required this.notifier,
  });

  @override
  ConsumerState<EditableSubgoalItem> createState() =>
      _EditableSubgoalItemState();
}

class _EditableSubgoalItemState extends ConsumerState<EditableSubgoalItem> {
  bool _isExpanded = false;
  final TextEditingController _resourceController = TextEditingController();

  @override
  void dispose() {
    _resourceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: Colors.grey.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subgoal Header with Title and Actions
            Row(
              children: [
                // Subgoal Icon
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: colorScheme.secondaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.task_alt,
                    color: colorScheme.secondary,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 8),

                // Subgoal Title Field
                Expanded(
                  child: TextFormField(
                    initialValue: widget.subgoal.title,
                    style: textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Subgoal Title',
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    onChanged: (value) {},
                  ),
                ),

                // Expand/Collapse Button
                IconButton(
                  icon: Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: colorScheme.secondary,
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.all(4),
                  visualDensity: VisualDensity.compact,
                ),

                // Delete Button
                IconButton(
                  icon: Icon(
                    Icons.delete_outline,
                    color: Colors.red.shade300,
                    size: 20,
                  ),
                  onPressed: () {
                    widget.notifier.removeSubgoal(
                      widget.goalId,
                      widget.subgoal.id,
                    );
                  },
                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.all(4),
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),

            // Duration Field (always visible)
            Padding(
              padding: const EdgeInsets.only(left: 32, top: 4, bottom: 4),
              child: Row(
                children: [
                  Icon(Icons.schedule, size: 16, color: Colors.grey.shade600),
                  const SizedBox(width: 4),
                  SizedBox(
                    width: 100,
                    child: TextFormField(
                      initialValue: widget.subgoal.duration,
                      style: textTheme.bodySmall!.copyWith(
                        color: Colors.grey.shade700,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Duration',
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
            ),

            // Expanded Content
            if (_isExpanded) ...[
              const SizedBox(height: 8),
              const Divider(height: 1),
              const SizedBox(height: 8),

              // Description Field
              TextFormField(
                initialValue: widget.subgoal.description,
                style: textTheme.bodyMedium,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(12),
                ),
                maxLines: 3,
                onChanged: (value) {},
              ),
              const SizedBox(height: 12),

              // Resources Section
              Text(
                'Resources',
                style: textTheme.titleSmall!.copyWith(
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 8),

              // Add Resource Field
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _resourceController,
                      decoration: const InputDecoration(
                        hintText: 'Add a link or resource',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(12),
                        isDense: true,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.add_circle),
                    onPressed: () {
                      if (_resourceController.text.isNotEmpty) {
                        widget.notifier.addResource(
                          widget.goalId,
                          widget.subgoal.id,
                          _resourceController.text,
                        );
                        _resourceController.clear();
                      }
                    },
                    color: colorScheme.primary,
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Resources List
              ...widget.subgoal.resources.asMap().entries.map(
                (entry) => Padding(
                  key: ValueKey(
                    '${widget.subgoal.id}_resource_${entry.key}',
                  ), // Add key for resources
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      Icon(Icons.link, size: 16, color: colorScheme.primary),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          entry.value,
                          style: textTheme.bodySmall!.copyWith(
                            color: colorScheme.primary,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          size: 16,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          widget.notifier.removeResource(
                            widget.goalId,
                            widget.subgoal.id,
                            entry.key,
                          );
                        },
                        constraints: const BoxConstraints(),
                        padding: const EdgeInsets.all(4),
                        visualDensity: VisualDensity.compact,
                      ),
                    ],
                  ),
                ),
              ),

              if (widget.subgoal.resources.isEmpty)
                Text(
                  'No resources added yet',
                  style: textTheme.bodySmall!.copyWith(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey.shade500,
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}
