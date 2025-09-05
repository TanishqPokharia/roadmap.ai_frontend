import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/core/common/entities/roadmap.dart';
import 'package:roadmap_ai/features/roadmap/presentation/screens/roadmap_update_page.dart';
import 'package:roadmap_ai/router/routes.dart';
import 'package:roadmap_ai/core/themes/colors.dart';

class SavedRoadmapTile extends StatelessWidget {
  const SavedRoadmapTile({super.key, required this.roadmap});
  final Roadmap roadmap;

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    final completion = calculateProgress(roadmap);
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: screenWidth * 0.03,
      children: [
        Column(
          spacing: screenHeight * 0.01,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              roadmap.title,
              style: textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            Row(
              spacing: screenHeight * 0.01,
              children: [
                SizedBox(
                  width: screenWidth * 0.3,
                  child: LinearProgressIndicator(
                    value: completion,
                    backgroundColor: colorScheme.primary.withAlpha(50),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      colorScheme.primary,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    minHeight: 8,
                  ),
                ),
                Text('${(completion * 100.0).toStringAsFixed(2)}%'),
              ],
            ),

            Text(
              'Contains ${roadmap.goals.length} goals',
              style: textTheme.bodyMedium!.copyWith(color: Colors.blueGrey),
            ),
            SizedBox(),
            Row(
              spacing: screenWidth * 0.005,
              children: [
                SizedBox(
                  height: screenHeight * 0.035,
                  child: FilledButton(
                    onPressed: () {
                      // Navigate to RoadmapUpdatePage
                      Navigator.of(context)
                          .push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  RoadmapUpdatePage(roadmap: roadmap),
                            ),
                          )
                          .then((updatedRoadmap) {
                            // Handle the updated roadmap if needed
                            // This could trigger a refresh of the parent page
                          });
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: buttonColor,
                      textStyle: textTheme.bodyLarge,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                    child: Text(
                      'View',
                      style: textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Consumer(
                  builder: (context, ref, child) {
                    return SizedBox(
                      height: screenHeight * 0.035,
                      child: OutlinedButton(
                        onPressed: () {
                          context.pushNamed(
                            AppRoutes.createPost,
                            extra: roadmap,
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          textStyle: textTheme.bodyMedium,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: colorScheme.primary),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                        ),
                        child: Text('Post'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        Container(
          width: screenHeight * 0.15,
          height: screenHeight * 0.12,
          decoration: BoxDecoration(
            color: colorScheme.primary.withAlpha(50),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Icon(Icons.route, size: 40, color: colorScheme.primary),
          ),
        ),
      ],
    );
  }

  double calculateProgress(Roadmap roadmap) {
    final goals = roadmap.goals;
    int subgoals = goals.fold(
      0,
      (combine, element) => combine + element.subgoals.length,
    );
    int completedSubgoals = goals.fold(
      0,
      (combine, element) =>
          combine +
          element.subgoals
              .where((subgoal) => subgoal.status?.completed == true)
              .length,
    );
    if (subgoals == 0) return 0;
    return completedSubgoals / subgoals;
  }
}
