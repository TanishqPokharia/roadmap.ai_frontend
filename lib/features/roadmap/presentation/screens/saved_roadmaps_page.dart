import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/features/roadmap/presentation/providers/saved_roadmaps/saved_roadmaps_notifier.dart';
import 'package:roadmap_ai/features/roadmap/presentation/widgets/saved_roadmap_tile.dart';

class SavedRoadmapsPage extends ConsumerWidget {
  const SavedRoadmapsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;
    final textTheme = context.textTheme;
    final savedRoadmapsProvider = ref.watch(savedRoadmapsNotifierProvider);

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
            child: savedRoadmapsProvider.when(
              data: (data) {
                if (data.isEmpty) {
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
                  padding: EdgeInsets.symmetric(vertical: 16),
                  itemBuilder: (context, index) {
                    final roadmap = data[index];
                    return SavedRoadmapTile(roadmap: roadmap);
                  },
                  separatorBuilder: (context, index) =>
                      SizedBox(height: screenHeight * 0.03),
                  itemCount: data.length,
                );
              },
              loading: () {
                return Center(child: CircularProgressIndicator());
              },
              error: (error, stackTrace) {
                return Center(child: Text('Error: $error'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
