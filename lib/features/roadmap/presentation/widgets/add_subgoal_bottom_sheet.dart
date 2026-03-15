import 'package:flutter/material.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';

class AddSubgoalBottomSheet extends StatefulWidget {
  final Function({
    required String title,
    required String description,
    required String duration,
    required List<String> resources,
  })
  onSave;

  const AddSubgoalBottomSheet({super.key, required this.onSave});

  @override
  State<AddSubgoalBottomSheet> createState() => _AddSubgoalBottomSheetState();
}

class _AddSubgoalBottomSheetState extends State<AddSubgoalBottomSheet> {
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
    _resourceControllers = [TextEditingController()];
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _durationController.dispose();
    for (final controller in _resourceControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 12,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: colorScheme.outline.withAlpha(128),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.add_task, color: colorScheme.primary, size: 20),
                SizedBox(width: 8),
                Text(
                  'Add New Subgoal',
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Flexible(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Subgoal Title',
                        style: textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8),
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
                      SizedBox(height: 16),
                      Text(
                        'Description',
                        style: textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8),
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
                      SizedBox(height: 16),
                      Text(
                        'Duration',
                        style: textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8),
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
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            'Resources (Optional)',
                            style: textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: _addResourceField,
                            icon: Icon(
                              Icons.add_circle,
                              color: colorScheme.primary,
                            ),
                            tooltip: 'Add Resource',
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      ...List.generate(
                        _resourceControllers.length,
                        (index) => Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _resourceControllers[index],
                                  decoration: InputDecoration(
                                    hintText:
                                        'Enter resource URL or description',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.link,
                                      color: colorScheme.secondary,
                                      size: 20,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
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
                      SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: colorScheme.onSurface.withAlpha(179),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.onSave(
                          title: _titleController.text.trim(),
                          description: _descriptionController.text.trim(),
                          duration: _durationController.text.trim(),
                          resources: _getValidResources(),
                        );
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Add Subgoal'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _addResourceField() {
    setState(() {
      _resourceControllers.add(TextEditingController());
    });
  }

  void _removeResourceField(int index) {
    if (_resourceControllers.length <= 1) return;
    setState(() {
      _resourceControllers[index].dispose();
      _resourceControllers.removeAt(index);
    });
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
    final durationRegex = RegExp(
      r'^\d+\s+(day|days|week|weeks|month|months|year|years)$',
    );

    if (!durationRegex.hasMatch(trimmedValue)) {
      return 'Duration must be in format: "1 day", "2 weeks", "3 months", etc.';
    }

    return null;
  }
}
