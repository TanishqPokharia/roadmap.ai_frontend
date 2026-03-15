import 'package:flutter/material.dart';
import 'package:roadmap_ai/core/common/entities/subgoal.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';

class EditSubgoalBottomSheet extends StatefulWidget {
  final Subgoal subgoal;
  final Function(String title, String description, List<String> resources)
  onSave;

  const EditSubgoalBottomSheet({
    super.key,
    required this.subgoal,
    required this.onSave,
  });

  @override
  State<EditSubgoalBottomSheet> createState() => _EditSubgoalBottomSheetState();
}

class _EditSubgoalBottomSheetState extends State<EditSubgoalBottomSheet> {
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

    _resourceControllers = widget.subgoal.resources
        .map((resource) => TextEditingController(text: resource))
        .toList();

    if (_resourceControllers.isEmpty) {
      _resourceControllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
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
                Icon(Icons.edit, color: colorScheme.primary, size: 20),
                SizedBox(width: 8),
                Text(
                  'Edit Subgoal',
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
                      Row(
                        children: [
                          Text(
                            'Resources',
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
                          _titleController.text.trim(),
                          _descriptionController.text.trim(),
                          _getValidResources(),
                        );
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Save'),
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
}
