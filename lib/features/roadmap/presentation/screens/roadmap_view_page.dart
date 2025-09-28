import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadmap_ai/core/common/entities/roadmap.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/features/roadmap/presentation/providers/roadmap_view/roadmap_view_notifier.dart';
import 'package:roadmap_ai/features/roadmap/presentation/widgets/editable_roadmap_tree.dart';

class RoadmapViewPage extends ConsumerWidget {
  final String roadmapId;

  const RoadmapViewPage({super.key, required this.roadmapId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roadmapView = roadmapViewNotifierProvider(roadmapId);

    return Scaffold(
      appBar: AppBar(),
      body: ref
          .watch(roadmapView)
          .when(
            data: (roadmapState) => _RoadmapContent(
              roadmapId: roadmapId,
              roadmap: roadmapState.roadmap,
            ),
            loading: () => const _LoadingContent(),
            error: (error, stack) => _ErrorContent(
              error: error,
              onRetry: () => ref.invalidate(roadmapView),
            ),
          ),
    );
  }
}

class _LoadingContent extends StatelessWidget {
  const _LoadingContent();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Loading roadmap...'),
        ],
      ),
    );
  }
}

class _ErrorContent extends StatelessWidget {
  final Object error;
  final VoidCallback onRetry;

  const _ErrorContent({required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: colorScheme.error),
            const SizedBox(height: 16),
            Text(
              'Failed to load roadmap',
              style: textTheme.headlineSmall?.copyWith(
                color: colorScheme.error,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withAlpha(179),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoadmapContent extends ConsumerWidget {
  final String roadmapId;
  final Roadmap roadmap;

  const _RoadmapContent({required this.roadmapId, required this.roadmap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;
    final textTheme = context.textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeight * 0.02),
          Text(
            roadmap.title,
            style: textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'View roadmap details',
            style: textTheme.bodyLarge!.copyWith(color: Colors.blueGrey),
          ),
          SizedBox(height: screenHeight * 0.03),
          Expanded(
            child: EditableRoadmapTree(
              roadmap: roadmap,
              isProgressEditable: true,
            ),
          ),
        ],
      ),
    );
  }
}
