import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/features/community/presentation/widgets/roadmap_tree.dart';
import 'package:roadmap_ai/features/roadmap/presentation/providers/roadmap/roadmap_notifier.dart';
import 'package:roadmap_ai/themes/colors.dart';

class CreateRoadmapPage extends ConsumerStatefulWidget {
  const CreateRoadmapPage({super.key});

  @override
  ConsumerState<CreateRoadmapPage> createState() => _CreateRoadmapPageState();
}

class _CreateRoadmapPageState extends ConsumerState<CreateRoadmapPage> {
  // make title controller and description controller
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
    final textTheme = context.textTheme;
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;

    ref.listen(roadmapNotifierProvider, (previous, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error.toString())));
      }
    });

    final roadmapProvider = ref.watch(roadmapNotifierProvider);
    return Padding(
      padding: EdgeInsets.only(left: screenWidth * 0.1),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          SizedBox(height: screenHeight * 0.04),
          Column(
            spacing: screenHeight * 0.01,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create Roadmap',
                style: textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Generate AI-powered roadmaps for any skill or goal within seconds',
                style: textTheme.bodyLarge!.copyWith(color: Colors.blueGrey),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.05),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: roadmapProvider.hasValue && roadmapProvider.value != null
                ? Padding(
                    padding: EdgeInsets.only(right: screenWidth * 0.1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: screenWidth * 0.03,
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 300,
                            minWidth: 100,
                            maxHeight: 100,
                            minHeight: 50,
                          ),
                          child: FilledButton(
                            onPressed: ref
                                .read(roadmapNotifierProvider.notifier)
                                .resetRoadmap,
                            child: Text('Generate Another Roadmap'),
                          ),
                        ),
                        RoadmapTree(roadmap: roadmapProvider.value!),
                      ],
                    ),
                  )
                : RoadmapCreationCard(
                    key: ValueKey('${roadmapProvider.hashCode}'),
                  ),
          ),
          SizedBox(height: screenHeight * 0.05),
        ],
      ),
    );
  }
}

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
    final textTheme = context.textTheme;
    final roadmapProvider = ref.watch(roadmapNotifierProvider);
    return Card(
      elevation: 10,
      margin: EdgeInsets.only(right: screenWidth * 0.1),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.02),
        child: Column(
          spacing: screenWidth * 0.03,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              spacing: screenWidth * 0.01,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Title',
                  style: textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: buttonColor,
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: 'Enter roadmap title',
                    hintStyle: textTheme.bodyLarge!.copyWith(
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
              ],
            ),
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
                    filled: true,
                    fillColor: buttonColor,
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: 'Describe your desired roadmap in detail',
                    hintStyle: textTheme.bodyLarge!.copyWith(
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 300,
                  minWidth: 100,
                  maxHeight: 100,
                  minHeight: 50,
                ),
                child: switch (roadmapProvider) {
                  AsyncLoading() => FilledButton.icon(
                    onPressed: () {},
                    label: SizedBox(),
                    iconAlignment: IconAlignment.end,
                    icon: LoadingAnimationWidget.fourRotatingDots(
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  _ => FilledButton.icon(
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
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
