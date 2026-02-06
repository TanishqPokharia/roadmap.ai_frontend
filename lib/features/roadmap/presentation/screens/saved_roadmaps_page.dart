import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/core/utils/failure_message.dart';
import 'package:roadmap_ai/features/roadmap/presentation/providers/saved_roadmaps/saved_roadmaps_notifier.dart';
import 'package:roadmap_ai/features/roadmap/presentation/widgets/saved_roadmap_tile.dart';

class SavedRoadmapsPage extends ConsumerStatefulWidget {
  const SavedRoadmapsPage({super.key});

  @override
  ConsumerState<SavedRoadmapsPage> createState() => _SavedRoadmapsPageState();
}

class _SavedRoadmapsPageState extends ConsumerState<SavedRoadmapsPage> {
  late ScrollController _scrollController;
  final Set<int> _animatedIndexes = {};
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        final notifier = ref.read(savedRoadmapsProvider.notifier);
        if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent) {
          notifier.getNextPage();
        }
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;
    final textTheme = context.textTheme;
    final savedRoadmaps = ref.watch(savedRoadmapsProvider);

    if (!kIsWeb && Platform.isAndroid) {
      return Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.04),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: screenHeight * 0.01,
              children: [
                Text(
                  'Saved Roadmaps',
                  style: textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Roadmaps you\'ve created or saved',
                  style: textTheme.bodyLarge!.copyWith(color: Colors.blueGrey),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.04),
            Expanded(
              child: savedRoadmaps.when(
                data: (data) {
                  if (data.roadmaps.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.route_outlined,
                            size: 64,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No saved roadmaps yet',
                            style: textTheme.titleMedium!.copyWith(
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Create a roadmap or save one from the community',
                            style: textTheme.bodyMedium!.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: () {
                      _animatedIndexes.clear();
                      return ref.refresh(savedRoadmapsProvider.future);
                    },
                    child: ListView.separated(
                      controller: _scrollController,
                      padding: EdgeInsets.only(bottom: 100),
                      itemBuilder: (context, index) {
                        final roadmap = data.roadmaps[index];

                        if (index == data.roadmaps.length - 1 &&
                            data.canGetMore) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SavedRoadmapTile(
                                roadmap: roadmap,
                                index: index,
                                animate: !_animatedIndexes.contains(index),
                              ),
                              SizedBox(height: screenHeight * 0.03),
                              Padding(
                                padding: const EdgeInsets.only(right: 200),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ],
                          );
                        }
                        return SavedRoadmapTile(
                          roadmap: roadmap,
                          index: index,
                          animate: shouldAnimate(index),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: screenHeight * 0.03),
                      itemCount: data.roadmaps.length,
                    ),
                  );
                },
                loading: () {
                  return Center(child: CircularProgressIndicator());
                },
                error: (error, stackTrace) {
                  return Center(child: Text(failureMessage(error)));
                },
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeight * 0.04),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: screenHeight * 0.01,
            children: [
              Text(
                'Saved Roadmaps',
                style: textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Roadmaps you\'ve created or saved',
                style: textTheme.bodyLarge!.copyWith(color: Colors.blueGrey),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.04),
          Expanded(
            child: savedRoadmaps.when(
              data: (data) {
                if (data.roadmaps.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.route_outlined,
                          size: 64,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No saved roadmaps yet',
                          style: textTheme.titleMedium!.copyWith(
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Create a roadmap or save one from the community',
                          style: textTheme.bodyMedium!.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.separated(
                  controller: _scrollController,
                  padding: EdgeInsets.only(bottom: 100, right: screenWidth / 3),
                  itemBuilder: (context, index) {
                    final roadmap = data.roadmaps[index];

                    if (index == data.roadmaps.length - 1 && data.canGetMore) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SavedRoadmapTile(
                            roadmap: roadmap,
                            index: index,
                            animate: !_animatedIndexes.contains(index),
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          Padding(
                            padding: const EdgeInsets.only(right: 200),
                            child: Center(child: CircularProgressIndicator()),
                          ),
                        ],
                      );
                    }
                    return SavedRoadmapTile(
                      roadmap: roadmap,
                      index: index,
                      animate: shouldAnimate(index),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      SizedBox(height: screenHeight * 0.03),
                  itemCount: data.roadmaps.length,
                );
              },
              loading: () {
                return Center(child: CircularProgressIndicator());
              },
              error: (error, stackTrace) {
                return Center(child: Text(failureMessage(error)));
              },
            ),
          ),
        ],
      ),
    );
  }

  bool shouldAnimate(int index) {
    return _animatedIndexes.add(index);
  }
}
