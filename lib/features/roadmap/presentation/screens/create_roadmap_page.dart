import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/features/community/presentation/widgets/roadmap_tree.dart';
import 'package:roadmap_ai/features/roadmap/presentation/providers/roadmap/roadmap_notifier.dart';
import 'package:roadmap_ai/features/roadmap/presentation/providers/save_roadmap/save_roadmap_notifier.dart';
import 'package:roadmap_ai/features/roadmap/presentation/widgets/roadmap_creation_card.dart';

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
    final colorScheme = context.colorScheme;

    ref.listen(roadmapNotifierProvider, (_, next) {
      if (next is AsyncError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error.toString())));
      }
    });

    ref.listen(saveRoadmapNotifierProvider, (_, next) {
      if (next is AsyncError) {
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: screenWidth * 0.02,
                          children: [
                            SizedBox(
                              width: screenWidth * 0.15,
                              height: screenHeight * 0.05,
                              child: FilledButton(
                                onPressed: ref
                                    .read(roadmapNotifierProvider.notifier)
                                    .resetRoadmap,
                                child: Text('Generate Another Roadmap'),
                              ),
                            ),
                            SizedBox(
                              width: screenWidth * 0.15,
                              height: screenHeight * 0.05,
                              child: switch (ref.watch(
                                saveRoadmapNotifierProvider,
                              )) {
                                AsyncLoading() => FilledButton(
                                  onPressed: null,
                                  style: FilledButton.styleFrom(
                                    backgroundColor: colorScheme.primary,
                                    disabledBackgroundColor:
                                        colorScheme.primary,
                                  ),
                                  child: SizedBox(
                                    width: screenHeight * 0.025,
                                    height: screenHeight * 0.025,
                                    child:
                                        LoadingAnimationWidget.staggeredDotsWave(
                                          color: Colors.white,
                                          size: screenHeight * 0.025,
                                        ),
                                  ),
                                ),
                                AsyncData(:final value) when value == true =>
                                  FilledButton.icon(
                                    onPressed: null,
                                    style: FilledButton.styleFrom(
                                      backgroundColor: colorScheme.primary,
                                      disabledBackgroundColor:
                                          colorScheme.primary,
                                    ),
                                    label: Text(
                                      'Saved',
                                      style: textTheme.bodyMedium!.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    icon: Icon(
                                      Icons.check_circle_rounded,
                                      color: Colors.white,
                                    ),
                                    iconAlignment: IconAlignment.end,
                                  ),
                                _ => FilledButton(
                                  onPressed: () {
                                    ref
                                        .read(
                                          saveRoadmapNotifierProvider.notifier,
                                        )
                                        .saveRoadmap(roadmapProvider.value!);
                                  },
                                  child: Text('Save Roadmap'),
                                ),
                              },
                            ),
                          ],
                        ),
                        Animate(
                          effects: [
                            FadeEffect(duration: Duration(milliseconds: 500)),
                          ],
                          child: Text(
                            "${roadmapProvider.value?.title}",
                            textAlign: TextAlign.center,
                            style: textTheme.headlineLarge!.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          "${roadmapProvider.value?.description}",
                          style: textTheme.titleLarge!.copyWith(
                            color: Colors.blueGrey,
                          ),
                        ),
                        Animate(
                          effects: [
                            FadeEffect(duration: Duration(milliseconds: 500)),
                          ],
                          child: RoadmapTree(roadmap: roadmapProvider.value!),
                        ),
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
