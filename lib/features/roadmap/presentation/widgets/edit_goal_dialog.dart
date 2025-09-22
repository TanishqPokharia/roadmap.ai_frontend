import 'package:flutter/material.dart';
import 'package:roadmap_ai/core/common/entities/goal.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';

class EditGoalDialog extends StatefulWidget {
  final Goal goal;
  final Function(String title) onSave;

  const EditGoalDialog({super.key, required this.goal, required this.onSave});

  @override
  State<EditGoalDialog> createState() => _EditGoalDialogState();
}

class _EditGoalDialogState extends State<EditGoalDialog> {
  late TextEditingController _titleController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.goal.title);
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
          Icon(Icons.edit, color: colorScheme.primary, size: 20),
          const SizedBox(width: 8),
          Text(
            'Edit Goal',
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
          child: const Text('Save'),
        ),
      ],
    );
  }
}
