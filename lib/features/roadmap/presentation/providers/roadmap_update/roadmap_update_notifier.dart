import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:roadmap_ai/core/common/entities/goal.dart';
import 'package:roadmap_ai/core/common/entities/roadmap.dart';
import 'package:roadmap_ai/core/common/entities/subgoal.dart';

// part 'roadmap_update_notifier.g.dart'; // Uncomment once code generation is done

// Provider for the legacy version (to maintain compatibility)
final roadmapUpdateProvider =
    StateNotifierProvider.family<RoadmapUpdateNotifier, Roadmap, Roadmap>(
      (ref, initialRoadmap) => RoadmapUpdateNotifier(initialRoadmap),
    );

// New provider using AsyncNotifier (will need code generation)
// Comment out for now until code generation is set up
/*
final roadmapUpdateAsyncProvider =
    AsyncNotifierProviderFamily<RoadmapUpdateAsyncNotifier, Roadmap, Roadmap>(
      () => RoadmapUpdateAsyncNotifier(),
    );
*/

// Legacy StateNotifier implementation
class RoadmapUpdateNotifier extends StateNotifier<Roadmap> {
  // Keep original roadmap for reference
  final Roadmap _originalRoadmap;
  // Temporary map to track changes before saving
  final Map<String, Map<String, bool>> _pendingChanges = {};

  RoadmapUpdateNotifier(super.roadmap) : _originalRoadmap = roadmap;

  void toggleSubgoalCompletion(String goalId, String subgoalId) {
    // Find the subgoal
    Subgoal? targetSubgoal;
    for (final goal in state.goals) {
      if (goal.id == goalId) {
        for (final subgoal in goal.subgoals) {
          if (subgoal.id == subgoalId) {
            targetSubgoal = subgoal;
            break;
          }
        }
      }
    }

    // Skip if not found or was already completed before
    if (targetSubgoal == null || targetSubgoal.status?.completedAt != null) {
      return;
    }

    // Initialize the goal map if it doesn't exist
    _pendingChanges[goalId] ??= {};

    // Toggle the completion status in our pending changes
    final currentValue =
        _pendingChanges[goalId]![subgoalId] ??
        (targetSubgoal.status?.completed ?? false);
    _pendingChanges[goalId]![subgoalId] = !currentValue;

    // Apply the pending changes to create a new display state
    _updateDisplayState();
  }

  // Apply pending changes to the display state without saving
  void _updateDisplayState() {
    final updatedGoals = state.goals.map((goal) {
      // Skip if no changes for this goal
      if (!_pendingChanges.containsKey(goal.id)) {
        return goal;
      }

      // Apply changes to this goal's subgoals
      final updatedSubgoals = goal.subgoals.map((subgoal) {
        // Skip if no change for this subgoal or was completed before
        if (!_pendingChanges[goal.id]!.containsKey(subgoal.id) ||
            subgoal.status?.completedAt != null) {
          return subgoal;
        }

        // Create new status with pending change
        final newCompleted = _pendingChanges[goal.id]![subgoal.id]!;
        final newStatus = SubgoalStatus(
          id: subgoal.status?.id ?? 'status_${subgoal.id}',
          completed: newCompleted,
          // Only set completedAt if newly completed and in temporary state
          completedAt: newCompleted ? null : null,
        );

        // Return updated subgoal with new status
        return Subgoal(
          id: subgoal.id,
          title: subgoal.title,
          description: subgoal.description,
          duration: subgoal.duration,
          resources: subgoal.resources,
          status: newStatus,
        );
      }).toList();

      // Return updated goal
      return Goal(id: goal.id, title: goal.title, subgoals: updatedSubgoals);
    }).toList();

    // Update the display state without saving
    state = Roadmap(
      id: state.id,
      userId: state.userId,
      title: state.title,
      goals: updatedGoals,
    );
  }

  // Discard all pending changes and revert to original
  void discardChanges() {
    _pendingChanges.clear();
    state = _originalRoadmap;
  }

  // Apply all pending changes and save
  Future<Roadmap> saveChanges() async {
    // Create the final state with proper completion timestamps
    final updatedGoals = state.goals.map((goal) {
      // Apply changes to this goal's subgoals
      final updatedSubgoals = goal.subgoals.map((subgoal) {
        // Skip if was completed before
        if (subgoal.status?.completedAt != null) {
          return subgoal;
        }

        // Check if this subgoal has pending changes
        if (_pendingChanges.containsKey(goal.id) &&
            _pendingChanges[goal.id]!.containsKey(subgoal.id)) {
          // Get the pending completed state
          final newCompleted = _pendingChanges[goal.id]![subgoal.id]!;

          // Create new status with proper timestamp
          final newStatus = SubgoalStatus(
            id: subgoal.status?.id ?? 'status_${subgoal.id}',
            completed: newCompleted,
            completedAt: newCompleted ? DateTime.now() : null,
          );

          // Return updated subgoal with new status
          return Subgoal(
            id: subgoal.id,
            title: subgoal.title,
            description: subgoal.description,
            duration: subgoal.duration,
            resources: subgoal.resources,
            status: newStatus,
          );
        }

        // No change
        return subgoal;
      }).toList();

      // Return updated goal
      return Goal(id: goal.id, title: goal.title, subgoals: updatedSubgoals);
    }).toList();

    // Create final roadmap with saved changes
    final savedRoadmap = Roadmap(
      id: state.id,
      userId: state.userId,
      title: state.title,
      goals: updatedGoals,
    );

    // Simulate saving to backend
    await Future.delayed(const Duration(seconds: 1));

    // Clear pending changes and update state
    _pendingChanges.clear();
    state = savedRoadmap;

    return savedRoadmap;
  }
}

/*
// This code is a template for future implementation using Riverpod code generation
// It should be uncommented and properly integrated after running build_runner

// @riverpod
// class RoadmapUpdateAsyncNotifier extends _$RoadmapUpdateAsyncNotifier {
//   // Keep track of original roadmap
//   late Roadmap _originalRoadmap;
  
//   // Temporary map to track changes before saving
//   final Map<String, Map<String, bool>> _pendingChanges = {};

//   @override
//   FutureOr<Roadmap> build(Roadmap initialRoadmap) {
//     // Store the original roadmap for reference
//     _originalRoadmap = initialRoadmap;
//     return initialRoadmap;
//   }

//   void toggleSubgoalCompletion(String goalId, String subgoalId) {
//     // Make sure state is loaded
//     if (state.isLoading) return;
    
//     final currentRoadmap = state.valueOrNull;
//     if (currentRoadmap == null) return;

//     // Find the subgoal
//     Subgoal? targetSubgoal;
//     for (final goal in currentRoadmap.goals) {
//       if (goal.id == goalId) {
//         for (final subgoal in goal.subgoals) {
//           if (subgoal.id == subgoalId) {
//             targetSubgoal = subgoal;
//             break;
//           }
//         }
//       }
//     }

//     // Skip if not found or was already completed before
//     if (targetSubgoal == null || targetSubgoal.status?.completedAt != null) {
//       return;
//     }

//     // Initialize the goal map if it doesn't exist
//     _pendingChanges[goalId] ??= {};

//     // Toggle the completion status in our pending changes
//     final currentValue =
//         _pendingChanges[goalId]![subgoalId] ??
//         (targetSubgoal.status?.completed ?? false);
//     _pendingChanges[goalId]![subgoalId] = !currentValue;

//     // Update the display state
//     _updateDisplayState();
//   }

//   // Apply pending changes to the display state without saving
//   void _updateDisplayState() {
//     final currentRoadmap = state.valueOrNull;
//     if (currentRoadmap == null) return;

//     final updatedGoals = currentRoadmap.goals.map((goal) {
//       // Skip if no changes for this goal
//       if (!_pendingChanges.containsKey(goal.id)) {
//         return goal;
//       }

//       // Apply changes to this goal's subgoals
//       final updatedSubgoals = goal.subgoals.map((subgoal) {
//         // Skip if no change for this subgoal or was completed before
//         if (!_pendingChanges[goal.id]!.containsKey(subgoal.id) ||
//             subgoal.status?.completedAt != null) {
//           return subgoal;
//         }

//         // Create new status with pending change
//         final newCompleted = _pendingChanges[goal.id]![subgoal.id]!;
//         final newStatus = SubgoalStatus(
//           id: subgoal.status?.id ?? 'status_${subgoal.id}',
//           completed: newCompleted,
//           // Only set completedAt if newly completed and in temporary state
//           completedAt: newCompleted ? null : null,
//         );

//         // Return updated subgoal with new status
//         return Subgoal(
//           id: subgoal.id,
//           title: subgoal.title,
//           description: subgoal.description,
//           duration: subgoal.duration,
//           resources: subgoal.resources,
//           status: newStatus,
//         );
//       }).toList();

//       // Return updated goal
//       return Goal(id: goal.id, title: goal.title, subgoals: updatedSubgoals);
//     }).toList();

//     // Update the display state without saving
//     state = AsyncData(
//       Roadmap(
//         id: currentRoadmap.id,
//         userId: currentRoadmap.userId,
//         title: currentRoadmap.title,
//         goals: updatedGoals,
//       ),
//     );
//   }

//   // Discard all pending changes and revert to original
//   void discardChanges() {
//     _pendingChanges.clear();
//     state = AsyncData(_originalRoadmap);
//   }

//   // Apply all pending changes and save
//   Future<Roadmap> saveChanges() async {
//     final currentRoadmap = state.valueOrNull;
//     if (currentRoadmap == null) throw Exception("No roadmap data available");
    
//     // Set to loading state
//     state = const AsyncLoading();

//     try {
//       // Create the final state with proper completion timestamps
//       final updatedGoals = currentRoadmap.goals.map((goal) {
//         // Apply changes to this goal's subgoals
//         final updatedSubgoals = goal.subgoals.map((subgoal) {
//           // Skip if was completed before
//           if (subgoal.status?.completedAt != null) {
//             return subgoal;
//           }

//           // Check if this subgoal has pending changes
//           if (_pendingChanges.containsKey(goal.id) &&
//               _pendingChanges[goal.id]!.containsKey(subgoal.id)) {
//             // Get the pending completed state
//             final newCompleted = _pendingChanges[goal.id]![subgoal.id]!;

//             // Create new status with proper timestamp
//             final newStatus = SubgoalStatus(
//               id: subgoal.status?.id ?? 'status_${subgoal.id}',
//               completed: newCompleted,
//               completedAt: newCompleted ? DateTime.now() : null,
//             );

//             // Return updated subgoal with new status
//             return Subgoal(
//               id: subgoal.id,
//               title: subgoal.title,
//               description: subgoal.description,
//               duration: subgoal.duration,
//               resources: subgoal.resources,
//               status: newStatus,
//             );
//           }

//           // No change
//           return subgoal;
//         }).toList();

//         // Return updated goal
//         return Goal(id: goal.id, title: goal.title, subgoals: updatedSubgoals);
//       }).toList();

//       // Create final roadmap with saved changes
//       final savedRoadmap = Roadmap(
//         id: currentRoadmap.id,
//         userId: currentRoadmap.userId,
//         title: currentRoadmap.title,
//         goals: updatedGoals,
//       );

//       // Simulate saving to backend
//       await Future.delayed(const Duration(seconds: 1));

//       // Clear pending changes and update state
//       _pendingChanges.clear();
//       state = AsyncData(savedRoadmap);
//       _originalRoadmap = savedRoadmap; // Update original reference

//       return savedRoadmap;
//     } catch (e, stackTrace) {
//       // Handle errors
//       state = AsyncError(e, stackTrace);
//       rethrow;
//     }
//   }
// }
// */
