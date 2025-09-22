import 'package:flutter/material.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';

class AddGoalDialog extends StatefulWidget {
  final Function(String title) onSave;

  const AddGoalDialog({super.key, required this.onSave});

  @override
  State<AddGoalDialog> createState() => _AddGoalDialogState();
}

class _AddGoalDialogState extends State<AddGoalDialog> {
  late TextEditingController _titleController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;

    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.add_task, color: colorScheme.primary, size: 20),
          const SizedBox(width: 8),
          Text(
            'Add New Goal',
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      content: SizedBox(
        width: 400,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Goal Title',
                style: textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Enter goal title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: Icon(Icons.flag, color: colorScheme.primary),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Goal title is required';
                  }
                  if (value.trim().length < 3) {
                    return 'Goal title must be at least 3 characters';
                  }
                  return null;
                },
                maxLines: 2,
                textInputAction: TextInputAction.done,
                autofocus: true,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer.withAlpha(77),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: colorScheme.primary.withAlpha(128)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: colorScheme.primary,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'You can add subgoals to this goal after creating it.',
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancel',
            style: TextStyle(color: colorScheme.onSurface.withAlpha(179)),
          ),
        ),
        FilledButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final newTitle = _titleController.text.trim();
              widget.onSave(newTitle);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Add Goal'),
        ),
      ],
    );
  }
}
