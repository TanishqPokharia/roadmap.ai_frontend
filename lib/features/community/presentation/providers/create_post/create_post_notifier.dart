import 'package:file_picker/file_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/common/entities/goal.dart';
import 'package:roadmap_ai/core/common/entities/roadmap.dart';
import 'package:roadmap_ai/core/common/entities/subgoal.dart';
import 'package:roadmap_ai/features/roadmap/presentation/providers/roadmap_view/roadmap_view_notifier.dart';

part 'create_post_notifier.g.dart';

class CreatePostState {
  final Roadmap? roadmap;
  final String? title;
  final String? description;
  final FilePickerResult? bannerImage;

  CreatePostState({
    required this.roadmap,
    this.title,
    this.description,
    this.bannerImage,
  });

  CreatePostState copyWith({
    Roadmap? roadmap,
    String? title,
    String? description,
    FilePickerResult? bannerImage,
  }) {
    return CreatePostState(
      roadmap: roadmap ?? this.roadmap,
      title: title ?? this.title,
      description: description ?? this.description,
      bannerImage: bannerImage ?? this.bannerImage,
    );
  }
}

@riverpod
class CreatePostNotifier extends _$CreatePostNotifier {
  @override
  FutureOr<CreatePostState> build(String roadmapId) {
    final roadmapViewData = ref.watch(roadmapViewNotifierProvider(roadmapId));
    return roadmapViewData.maybeWhen(
      data: (data) => CreatePostState(roadmap: data.roadmap),
      orElse: () => CreatePostState(roadmap: null),
    );
  }

  void addRoadmapGoal(Goal goal) {
    if (state.value!.roadmap == null) return;
    final updatedGoals = [...state.value!.roadmap!.goals, goal];
    final updatedRoadmap = state.value!.roadmap!.copyWith(goals: updatedGoals);
    state = AsyncData(state.value!.copyWith(roadmap: updatedRoadmap));
  }

  void addNewGoal(String title) {
    if (state.value!.roadmap == null) return;

    // Generate a unique ID for the new goal
    final newId = 'goal_${DateTime.now().millisecondsSinceEpoch}';

    final newGoal = Goal(
      id: newId,
      title: title,
      subgoals: [], // Start with empty subgoals
    );

    addRoadmapGoal(newGoal);
  }

  void removeRoadmapGoal(Goal goal) {
    if (state.value!.roadmap == null) return;
    final updatedGoals = state.value!.roadmap!.goals
        .where((g) => g != goal)
        .toList();
    final updatedRoadmap = state.value!.roadmap!.copyWith(goals: updatedGoals);
    state = AsyncData(state.value!.copyWith(roadmap: updatedRoadmap));
  }

  void addRoadmapSubgoal(String goalId, Subgoal subgoal) {
    if (state.value!.roadmap == null) return;
    final updatedGoals = state.value!.roadmap!.goals.map((goal) {
      if (goal.id == goalId) {
        final updatedSubgoals = [...goal.subgoals, subgoal];
        return goal.copyWith(subgoals: updatedSubgoals);
      }
      return goal;
    }).toList();
    final updatedRoadmap = state.value!.roadmap!.copyWith(goals: updatedGoals);
    state = AsyncData(state.value!.copyWith(roadmap: updatedRoadmap));
  }

  void addNewSubgoal({
    required String goalId,
    required String title,
    required String description,
    required String duration,
    required List<String> resources,
  }) {
    if (state.value!.roadmap == null) return;

    // Generate unique IDs
    final subgoalId = 'subgoal_${DateTime.now().millisecondsSinceEpoch}';
    final statusId = 'status_${DateTime.now().millisecondsSinceEpoch}';

    final newSubgoal = Subgoal(
      id: subgoalId,
      title: title,
      description: description,
      duration: duration,
      resources: resources,
      status: SubgoalStatus(id: statusId, completed: false, completedAt: null),
    );

    addRoadmapSubgoal(goalId, newSubgoal);
  }

  void removeRoadmapSubgoal(String goalId, Subgoal subgoal) {
    if (state.value!.roadmap == null) return;
    final updatedGoals = state.value!.roadmap!.goals.map((goal) {
      if (goal.id == goalId) {
        final updatedSubgoals = goal.subgoals
            .where((sg) => sg != subgoal)
            .toList();
        return goal.copyWith(subgoals: updatedSubgoals);
      }
      return goal;
    }).toList();
    final updatedRoadmap = state.value!.roadmap!.copyWith(goals: updatedGoals);
    state = AsyncData(state.value!.copyWith(roadmap: updatedRoadmap));
  }

  void setGoalTitle(String goalId, String title) {
    if (state.value!.roadmap == null) return;
    final updatedGoals = state.value!.roadmap!.goals.map((goal) {
      if (goal.id == goalId) {
        return goal.copyWith(title: title);
      }
      return goal;
    }).toList();
    final updatedRoadmap = state.value!.roadmap!.copyWith(goals: updatedGoals);
    state = AsyncData(state.value!.copyWith(roadmap: updatedRoadmap));
  }

  void setSubgoalTitle(String goalId, String subgoalId, String title) {
    if (state.value!.roadmap == null) return;
    final updatedGoals = state.value!.roadmap!.goals.map((goal) {
      if (goal.id == goalId) {
        final updatedSubgoals = goal.subgoals.map((subgoal) {
          if (subgoal.id == subgoalId) {
            return subgoal.copyWith(title: title);
          }
          return subgoal;
        }).toList();
        return goal.copyWith(subgoals: updatedSubgoals);
      }
      return goal;
    }).toList();
    final updatedRoadmap = state.value!.roadmap!.copyWith(goals: updatedGoals);
    state = AsyncData(state.value!.copyWith(roadmap: updatedRoadmap));
  }

  void setSubgoalDetails(
    String goalId,
    String subgoalId,
    String title,
    String description,
    List<String> resources,
  ) {
    if (state.value!.roadmap == null) return;
    final updatedGoals = state.value!.roadmap!.goals.map((goal) {
      if (goal.id == goalId) {
        final updatedSubgoals = goal.subgoals.map((subgoal) {
          if (subgoal.id == subgoalId) {
            return subgoal.copyWith(
              title: title,
              description: description,
              resources: resources,
            );
          }
          return subgoal;
        }).toList();
        return goal.copyWith(subgoals: updatedSubgoals);
      }
      return goal;
    }).toList();
    final updatedRoadmap = state.value!.roadmap!.copyWith(goals: updatedGoals);
    state = AsyncData(state.value!.copyWith(roadmap: updatedRoadmap));
  }

  void setTitle(String title) {
    state = AsyncData(state.value!.copyWith(title: title));
  }

  void setDescription(String description) {
    state = AsyncData(state.value!.copyWith(description: description));
  }

  void setBannerImage(FilePickerResult bannerImage) {
    state = AsyncData(state.value!.copyWith(bannerImage: bannerImage));
  }
}
