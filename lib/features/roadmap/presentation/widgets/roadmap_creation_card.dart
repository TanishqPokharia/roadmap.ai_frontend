import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/features/roadmap/presentation/providers/roadmap/roadmap_notifier.dart';
import 'package:roadmap_ai/features/roadmap/presentation/widgets/hover_shadow.dart';

class RoadmapCreationCard extends ConsumerStatefulWidget {
  const RoadmapCreationCard({super.key});

  @override
  ConsumerState<RoadmapCreationCard> createState() =>
      _RoadmapCreationCardState();
}

class _RoadmapCreationCardState extends ConsumerState<RoadmapCreationCard> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenWidth;
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;
    final theme = context.theme;
    final roadmapProvider = ref.watch(roadmapNotifierProvider);
    return Card(
      elevation: 10,
      color: theme.cardColor,
      margin: EdgeInsets.only(right: screenWidth * 0.1),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.02),
        child: Column(
          spacing: screenWidth * 0.03,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: screenWidth * 0.01,
              children: [
                Text(
                  'Description',
                  style: textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  controller: _descriptionController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: 'Describe your desired roadmap in detail',
                  ),
                ),
              ],
            ),
            Center(
              child: LayoutBuilder(
                builder: (context, constraints) => SizedBox(
                  width: constraints.maxWidth * 0.2,
                  height: 50,
                  child: switch (roadmapProvider) {
                    AsyncLoading() => FilledButton(
                      onPressed: () {},
                      child: LoadingAnimationWidget.fourRotatingDots(
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    _ => HoverShadow(
                      shadowColor: colorScheme.primary.withAlpha(100),
                      child: FilledButton.icon(
                        onPressed: () {
                          if (_descriptionController.text.isNotEmpty) {
                            ref
                                .read(roadmapNotifierProvider.notifier)
                                .getRoadmap(_descriptionController.text);
                          }
                        },
                        iconAlignment: IconAlignment.end,
                        icon: Icon(Icons.auto_awesome_rounded),
                        label: const Text('Generate Roadmap'),
                      ),
                    ),
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
