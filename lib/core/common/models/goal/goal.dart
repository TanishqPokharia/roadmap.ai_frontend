import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:roadmap_ai/core/common/entities/goal.dart';
import 'package:roadmap_ai/core/common/models/subgoal/subgoal.dart';

part 'goal.freezed.dart';
part 'goal.g.dart';

@freezed
abstract class GoalModel with _$GoalModel {
  factory GoalModel({
    required String? id,
    required String title,
    required List<SubgoalModel> subgoals,
  }) = _GoalModel;

  factory GoalModel.fromJson(Map<String, dynamic> json) =>
      _$GoalModelFromJson(json);

  factory GoalModel.fromEntity(Goal goal) {
    return GoalModel(
      id: goal.id,
      title: goal.title,
      subgoals: goal.subgoals
          .map((subgoal) => SubgoalModel.fromEntity(subgoal))
          .toList(),
    );
  }
}

extension GoalModelEntity on GoalModel {
  Goal toEntity() {
    return Goal(
      id: id ?? 'id ${DateTime.now().millisecondsSinceEpoch}',
      title: title,
      subgoals: subgoals.map((subgoal) => subgoal.toEntity()).toList(),
    );
  }
}
