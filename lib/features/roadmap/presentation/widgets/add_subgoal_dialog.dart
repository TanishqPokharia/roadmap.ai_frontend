import 'package:flutter/material.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';

class AddSubgoalDialog extends StatefulWidget {
  final Function({
    required String title,
    required String description,
    required String duration,
    required List<String> resources,
  })
  onSave;

  const AddSubgoalDialog({super.key, required this.onSave});

  @override
  State<AddSubgoalDialog> createState() => _AddSubgoalDialogState();
}

class _AddSubgoalDialogState extends State<AddSubgoalDialog> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _durationController;
  late List<TextEditingController> _resourceControllers;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _durationController = TextEditingController();

    // Start with one empty resource field
    _resourceControllers = [TextEditingController()];
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _durationController.dispose();
    for (var controller in _resourceControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addResourceField() {
    setState(() {
      _resourceControllers.add(TextEditingController());
    });
  }

  void _removeResourceField(int index) {
    if (_resourceControllers.length > 1) {
      setState(() {
        _resourceControllers[index].dispose();
        _resourceControllers.removeAt(index);
      });
    }
  }

  List<String> _getValidResources() {
    return _resourceControllers
        .map((controller) => controller.text.trim())
        .where((resource) => resource.isNotEmpty)
        .toList();
  }

  String? _validateDuration(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Duration is required';
    }

    final trimmedValue = value.trim().toLowerCase();

    // Regular expression to match duration patterns like "1 day", "2 weeks", "3 months", etc.
    final durationRegex = RegExp(
      r'^\d+\s+(day|days|week|weeks|month|months|year|years)$',
    );

    if (!durationRegex.hasMatch(trimmedValue)) {
      return 'Duration must be in format: "1 day", "2 weeks", "3 months", etc.';
    }

    return null;
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
            'Add New Subgoal',
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      content: SizedBox(
        width: 500,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title Section
                Text(
                  'Subgoal Title',
                  style: textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: 'Enter subgoal title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: Icon(
                      Icons.task_alt,
                      color: colorScheme.primary,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Subgoal title is required';
                    }
                    if (value.trim().length < 3) {
                      return 'Subgoal title must be at least 3 characters';
                    }
                    return null;
                  },
                  maxLines: 2,
                  textInputAction: TextInputAction.next,
                  autofocus: true,
                ),
                const SizedBox(height: 16),

                // Description Section
                Text(
                  'Description',
                  style: textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    hintText: 'Enter detailed description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: Icon(
                      Icons.description,
                      color: colorScheme.primary,
                    ),
                    alignLabelWithHint: true,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Description is required';
                    }
                    if (value.trim().length < 10) {
                      return 'Description must be at least 10 characters';
                    }
                    return null;
                  },
                  maxLines: 3,
                  minLines: 2,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),

                // Duration Section
                Text(
                  'Duration',
                  style: textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _durationController,
                  decoration: InputDecoration(
                    hintText: 'e.g., 2 weeks, 1 month, 3 days',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: Icon(
                      Icons.schedule,
                      color: colorScheme.primary,
                    ),
                  ),
                  validator: _validateDuration,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),

                // Resources Section
                Row(
                  children: [
                    Text(
                      'Resources (Optional)',
                      style: textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: _addResourceField,
                      icon: Icon(Icons.add_circle, color: colorScheme.primary),
                      tooltip: 'Add Resource',
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Resource Fields
                ...List.generate(
                  _resourceControllers.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _resourceControllers[index],
                            decoration: InputDecoration(
                              hintText: 'Enter resource URL or description',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              prefixIcon: Icon(
                                Icons.link,
                                color: colorScheme.secondary,
                                size: 20,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                            ),
                            textInputAction:
                                index == _resourceControllers.length - 1
                                ? TextInputAction.done
                                : TextInputAction.next,
                          ),
                        ),
                        if (_resourceControllers.length > 1)
                          IconButton(
                            onPressed: () => _removeResourceField(index),
                            icon: Icon(
                              Icons.remove_circle,
                              color: colorScheme.error,
                            ),
                            tooltip: 'Remove Resource',
                          ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer.withAlpha(77),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: colorScheme.primary.withAlpha(128),
                    ),
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
                          'The subgoal will be added to the goal and will start as incomplete.',
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
              final title = _titleController.text.trim();
              final description = _descriptionController.text.trim();
              final duration = _durationController.text.trim();
              final resources = _getValidResources();

              widget.onSave(
                title: title,
                description: description,
                duration: duration,
                resources: resources,
              );
              Navigator.of(context).pop();
            }
          },
          child: const Text('Add Subgoal'),
        ),
      ],
    );
  }
}
