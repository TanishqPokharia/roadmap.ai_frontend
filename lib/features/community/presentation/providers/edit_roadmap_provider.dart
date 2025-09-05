import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/common/entities/goal.dart';
import 'package:roadmap_ai/core/common/entities/roadmap.dart';
import 'package:roadmap_ai/core/common/entities/subgoal.dart';

part 'edit_roadmap_provider.g.dart';

@riverpod
class EditRoadmapNotifier extends _$EditRoadmapNotifier {
  @override
  Roadmap build(Roadmap roadmap) {
    // Initialize with an empty roadmap - will be set when page is created
    return roadmap;
  }

  // Initialize with a cleaned roadmap (no status)
  void initializeWithRoadmap(Roadmap roadmap) {
    // final cleanRoadmap = RoadmapUtils.createSharableRoadmap(roadmap);
    state = roadmap;
  }

  // Update the roadmap title
  void updateTitle(String title) {
    state = Roadmap(
      id: state.id,
      userId: state.userId,
      title: title,
      goals: state.goals,
      description: state.description,
    );
  }

  // Add a new goal
  void addGoal() {
    final newGoal = Goal(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: 'New Goal',
      subgoals: [],
    );

    final updatedGoals = List<Goal>.from(state.goals)..add(newGoal);

    state = Roadmap(
      id: state.id,
      userId: state.userId,

      title: state.title,
      description: state.description,
      goals: updatedGoals,
    );
  }

  // Update a goal's title
  void updateGoalTitle(String goalId, String newTitle) {
    final updatedGoals = state.goals.map((goal) {
      if (goal.id == goalId) {
        return Goal(id: goal.id, title: newTitle, subgoals: goal.subgoals);
      }
      return goal;
    }).toList();

    state = Roadmap(
      id: state.id,
      userId: state.userId,
      title: state.title,
      description: state.description,
      goals: updatedGoals,
    );
  }

  // Remove a goal
  void removeGoal(String goalId) {
    final updatedGoals = state.goals
        .where((goal) => goal.id != goalId)
        .toList();

    state = Roadmap(
      id: state.id,
      userId: state.userId,
      title: state.title,
      description: state.description,
      goals: updatedGoals,
    );
  }

  // Add a new subgoal to a goal
  void addSubgoal(String goalId) {
    final updatedGoals = state.goals.map((goal) {
      if (goal.id == goalId) {
        final newSubgoal = Subgoal(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: 'New Subgoal',
          description: 'Description',
          duration: '1 week',
          resources: [],
          status: null,
        );

        final updatedSubgoals = List<Subgoal>.from(goal.subgoals)
          ..add(newSubgoal);

        return Goal(id: goal.id, title: goal.title, subgoals: updatedSubgoals);
      }
      return goal;
    }).toList();

    state = Roadmap(
      id: state.id,
      userId: state.userId,
      title: state.title,
      goals: updatedGoals,
      description: state.description,
    );
  }

  // Update a subgoal
  void updateSubgoal({
    required String goalId,
    required String subgoalId,
    String? title,
    String? description,
    String? duration,
    List<String>? resources,
  }) {
    final updatedGoals = state.goals.map((goal) {
      if (goal.id == goalId) {
        final updatedSubgoals = goal.subgoals.map((subgoal) {
          if (subgoal.id == subgoalId) {
            return Subgoal(
              id: subgoal.id,
              title: title ?? subgoal.title,
              description: description ?? subgoal.description,
              duration: duration ?? subgoal.duration,
              resources: resources ?? subgoal.resources,
              status: null,
            );
          }
          return subgoal;
        }).toList();

        return Goal(id: goal.id, title: goal.title, subgoals: updatedSubgoals);
      }
      return goal;
    }).toList();

    state = Roadmap(
      id: state.id,
      userId: state.userId,
      title: state.title,
      goals: updatedGoals,
      description: state.description,
    );
  }

  // Remove a subgoal
  void removeSubgoal(String goalId, String subgoalId) {
    final updatedGoals = state.goals.map((goal) {
      if (goal.id == goalId) {
        final updatedSubgoals = goal.subgoals
            .where((subgoal) => subgoal.id != subgoalId)
            .toList();

        return Goal(id: goal.id, title: goal.title, subgoals: updatedSubgoals);
      }
      return goal;
    }).toList();

    state = Roadmap(
      id: state.id,
      userId: state.userId,
      title: state.title,
      goals: updatedGoals,
      description: state.description,
    );
  }

  // Add a resource to a subgoal
  void addResource(String goalId, String subgoalId, String resource) {
    final updatedGoals = state.goals.map((goal) {
      if (goal.id == goalId) {
        final updatedSubgoals = goal.subgoals.map((subgoal) {
          if (subgoal.id == subgoalId) {
            final updatedResources = List<String>.from(subgoal.resources)
              ..add(resource);

            return Subgoal(
              id: subgoal.id,
              title: subgoal.title,
              description: subgoal.description,
              duration: subgoal.duration,
              resources: updatedResources,
              status: null,
            );
          }
          return subgoal;
        }).toList();

        return Goal(id: goal.id, title: goal.title, subgoals: updatedSubgoals);
      }
      return goal;
    }).toList();

    state = Roadmap(
      id: state.id,
      userId: state.userId,
      title: state.title,
      goals: updatedGoals,
      description: state.description,
    );
  }

  // Remove a resource from a subgoal
  void removeResource(String goalId, String subgoalId, int resourceIndex) {
    final updatedGoals = state.goals.map((goal) {
      if (goal.id == goalId) {
        final updatedSubgoals = goal.subgoals.map((subgoal) {
          if (subgoal.id == subgoalId) {
            final updatedResources = List<String>.from(subgoal.resources);
            if (resourceIndex >= 0 && resourceIndex < updatedResources.length) {
              updatedResources.removeAt(resourceIndex);
            }

            return Subgoal(
              id: subgoal.id,
              title: subgoal.title,
              description: subgoal.description,
              duration: subgoal.duration,
              resources: updatedResources,
              status: null,
            );
          }
          return subgoal;
        }).toList();

        return Goal(id: goal.id, title: goal.title, subgoals: updatedSubgoals);
      }
      return goal;
    }).toList();

    state = Roadmap(
      id: state.id,
      userId: state.userId,
      title: state.title,
      goals: updatedGoals,
      description: state.description,
    );
  }
}
