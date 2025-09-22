import 'package:flutter/material.dart';
import 'package:roadmap_ai/core/common/entities/subgoal.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';

class EditSubgoalDialog extends StatefulWidget {
  final Subgoal subgoal;
  final Function(String title, String description, List<String> resources)
  onSave;

  const EditSubgoalDialog({
    super.key,
    required this.subgoal,
    required this.onSave,
  });

  @override
  State<EditSubgoalDialog> createState() => _EditSubgoalDialogState();
}

class _EditSubgoalDialogState extends State<EditSubgoalDialog> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late List<TextEditingController> _resourceControllers;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.subgoal.title);
    _descriptionController = TextEditingController(
      text: widget.subgoal.description,
    );

    // Initialize resource controllers with existing resources
    _resourceControllers = widget.subgoal.resources
        .map((resource) => TextEditingController(text: resource))
        .toList();

    // Add one empty controller if no resources exist
    if (_resourceControllers.isEmpty) {
      _resourceControllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
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
            'Edit Subgoal',
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
                  textInputAction: TextInputAction.newline,
                ),
                const SizedBox(height: 16),

                // Resources Section
                Row(
                  children: [
                    Text(
                      'Resources',
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
                            textInputAction: TextInputAction.next,
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

                if (_resourceControllers.isEmpty)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: colorScheme.outline.withAlpha(128),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, color: colorScheme.primary),
                        const SizedBox(width: 8),
                        Text(
                          'No resources added yet',
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurface.withAlpha(179),
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
              final newTitle = _titleController.text.trim();
              final newDescription = _descriptionController.text.trim();
              final validResources = _getValidResources();

              widget.onSave(newTitle, newDescription, validResources);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
