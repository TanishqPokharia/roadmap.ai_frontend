import 'package:roadmap_ai/core/common/entities/goal.dart';
import 'package:roadmap_ai/core/common/entities/roadmap.dart';
import 'package:roadmap_ai/core/common/entities/subgoal.dart';
import 'package:uuid/uuid.dart';

class RoadmapUtils {
  // Create a copy of a roadmap without SubgoalStatus for sharing
  // Optimized to reduce unnecessary object creation and processing time
  static Roadmap createSharableRoadmap(Roadmap roadmap) {
    if (roadmap.goals.isEmpty) {
      // Quick return for empty roadmaps - reuse existing object where possible
      return Roadmap(
        id: roadmap.id,
        userId: roadmap.userId,
        title: roadmap.title,
        goals: const [],
        description: roadmap.description,
      );
    }

    // Pre-allocate lists with known sizes for better performance
    final newGoals = <Goal>[]..length = roadmap.goals.length;

    for (int i = 0; i < roadmap.goals.length; i++) {
      final goal = roadmap.goals[i];

      if (goal.subgoals.isEmpty) {
        // Fast path for goals without subgoals
        newGoals[i] = Goal(id: goal.id, title: goal.title, subgoals: const []);
        continue;
      }

      // Pre-allocate subgoals list
      final newSubgoals = <Subgoal>[]..length = goal.subgoals.length;

      for (int j = 0; j < goal.subgoals.length; j++) {
        final subgoal = goal.subgoals[j];
        newSubgoals[j] = Subgoal(
          id: subgoal.id,
          title: subgoal.title,
          description: subgoal.description,
          duration: subgoal.duration,
          resources: subgoal.resources, // Reuse the list if it's immutable
          status: null, // Remove status
        );
      }

      newGoals[i] = Goal(id: goal.id, title: goal.title, subgoals: newSubgoals);
    }

    // Return a new roadmap with the same ID but without status info
    return Roadmap(
      id: roadmap.id,
      userId: roadmap.userId,
      title: roadmap.title,
      description: roadmap.description,
      goals: newGoals,
    );
  }

  // Generate a new ID for any entity
  static String generateId() {
    return const Uuid().v4();
  }
}
