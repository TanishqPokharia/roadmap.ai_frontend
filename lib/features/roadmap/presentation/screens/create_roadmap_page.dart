import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:roadmap_ai/core/common/toast/error.dart';
import 'package:roadmap_ai/core/constants/constants.dart';
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

class _CreateRoadmapPageState extends ConsumerState<CreateRoadmapPage>
    with AutomaticKeepAliveClientMixin {
  late TextEditingController _descriptionController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final textTheme = context.textTheme;
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;
    final colorScheme = context.colorScheme;

    ref.listen(roadmapProvider, (_, next) {
      if (next is AsyncError) {
        showErrorToast(context: context, error: next.error.toString());
      }
    });

    ref.listen(saveRoadmapProvider, (_, next) {
      if (next is AsyncError) {
        showErrorToast(context: context, error: next.error.toString());
      }
    });

    final roadmap = ref.watch(roadmapProvider);

    if (AppConstants.isAndroid) {
      return Scaffold(
        body: ListView(
          padding: EdgeInsets.only(left: 20, right: 20, top: 50),
          children: [
            Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create Roadmap',
                  style: textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Generate AI-powered roadmaps for any skill or goal within seconds',
                  style: textTheme.bodyLarge!.copyWith(),
                ),
              ],
            ),
            SizedBox(height: 20),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: roadmap.value != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: screenWidth * 0.03,
                      children: [
                        Animate(
                          effects: [
                            FadeEffect(duration: Duration(milliseconds: 500)),
                          ],
                          child: Text(
                            "${roadmap.value?.title}",
                            textAlign: TextAlign.start,
                            style: textTheme.titleLarge!.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          "${roadmap.value?.description}",
                          style: textTheme.titleMedium!.copyWith(),
                        ),
                        Animate(
                          effects: [
                            FadeEffect(duration: Duration(milliseconds: 500)),
                          ],
                          child: RoadmapTree(roadmap: roadmap.value!),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 10,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: FilledButton(
                                onPressed: ref
                                    .read(roadmapProvider.notifier)
                                    .resetRoadmap,
                                child: Text('Generate Another Roadmap'),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: switch (ref.watch(saveRoadmapProvider)) {
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
                                          color: colorScheme.onPrimary,
                                          size: screenHeight * 0.025,
                                        ),
                                  ),
                                ),
                                AsyncData(:final value) when value == true =>
                                  FilledButton.icon(
                                    onPressed: null,
                                    style: FilledButton.styleFrom(
                                      disabledBackgroundColor:
                                          colorScheme.primary,
                                    ),
                                    label: Text(
                                      'Saved',
                                      style: textTheme.bodyMedium!.copyWith(
                                        color: colorScheme.onPrimary,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "",
                                      ),
                                    ),

                                    icon: Icon(
                                      Icons.check_circle_rounded,
                                      color: colorScheme.onPrimary,
                                    ),
                                    iconAlignment: IconAlignment.end,
                                  ),
                                _ => FilledButton(
                                  onPressed: () {
                                    ref
                                        .read(saveRoadmapProvider.notifier)
                                        .saveRoadmap(roadmap.value!);
                                  },
                                  child: Text('Save Roadmap'),
                                ),
                              },
                            ),
                          ],
                        ),
                      ],
                    )
                  : RoadmapCreationCard(controller: _descriptionController),
            ),
            SizedBox(height: screenHeight * 0.05),
          ],
        ),
      );
    }
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
            child: roadmap.value != null
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
                                    .read(roadmapProvider.notifier)
                                    .resetRoadmap,
                                child: Text('Generate Another Roadmap'),
                              ),
                            ),
                            SizedBox(
                              width: screenWidth * 0.15,
                              height: screenHeight * 0.05,
                              child: switch (ref.watch(saveRoadmapProvider)) {
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
                                        .read(saveRoadmapProvider.notifier)
                                        .saveRoadmap(roadmap.value!);
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
                            "${roadmap.value?.title}",
                            textAlign: TextAlign.center,
                            style: textTheme.headlineLarge!.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          "${roadmap.value?.description}",
                          style: textTheme.titleLarge!.copyWith(
                            color: Colors.blueGrey,
                          ),
                        ),
                        Animate(
                          effects: [
                            FadeEffect(duration: Duration(milliseconds: 500)),
                          ],
                          child: RoadmapTree(roadmap: roadmap.value!),
                        ),
                      ],
                    ),
                  )
                : RoadmapCreationCard(controller: _descriptionController),
          ),
          SizedBox(height: screenHeight * 0.05),
        ],
      ),
    );
  }
}
