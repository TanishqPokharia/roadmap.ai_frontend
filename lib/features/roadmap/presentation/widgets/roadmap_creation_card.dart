import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/features/roadmap/presentation/providers/roadmap/roadmap_notifier.dart';
import 'package:roadmap_ai/features/roadmap/presentation/widgets/hover_shadow.dart';

class RoadmapCreationCard extends ConsumerStatefulWidget {
  const RoadmapCreationCard({super.key, required this.controller});

  final TextEditingController controller;

  @override
  ConsumerState<RoadmapCreationCard> createState() =>
      _RoadmapCreationCardState();
}

class _RoadmapCreationCardState extends ConsumerState<RoadmapCreationCard> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenWidth;
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;
    final theme = context.theme;
    final roadmap = ref.watch(roadmapProvider);
    if (!kIsWeb && Platform.isAndroid) {
      return Card(
        elevation: 10,
        color: colorScheme.surfaceContainer,
        child: Padding(
          padding: EdgeInsets.all(20),
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
                  SizedBox(height: 10),
                  TextField(
                    textAlign: TextAlign.start,
                    controller: widget.controller,
                    maxLines: 17,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsetsDirectional.zero,
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      hintText: 'Describe your desired roadmap in detail',
                      hintStyle: textTheme.bodyMedium?.copyWith(),
                    ),
                  ),
                ],
              ),
              Center(
                child: switch (roadmap) {
                  AsyncLoading() => SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {},
                      child: LoadingAnimationWidget.fourRotatingDots(
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                  _ => SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {
                        if (widget.controller.text.isNotEmpty) {
                          ref
                              .read(roadmapProvider.notifier)
                              .getRoadmap(widget.controller.text);
                        }
                      },
                      iconAlignment: IconAlignment.end,
                      icon: Icon(Icons.auto_awesome_rounded),
                      label: Text(
                        'Generate Roadmap',
                        style: textTheme.bodyLarge?.copyWith(
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                },
              ),
            ],
          ),
        ),
      );
    }
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
                  controller: widget.controller,
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
                  child: switch (roadmap) {
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
                          if (widget.controller.text.isNotEmpty) {
                            ref
                                .read(roadmapProvider.notifier)
                                .getRoadmap(widget.controller.text);
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
