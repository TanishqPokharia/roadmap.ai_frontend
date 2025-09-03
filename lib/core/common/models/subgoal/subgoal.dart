import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:roadmap_ai/core/common/entities/subgoal.dart';

part 'subgoal.freezed.dart';
part 'subgoal.g.dart';

@freezed
abstract class SubgoalModel with _$SubgoalModel {
  factory SubgoalModel({
    required String? id,
    required String title,
    required String description,
    required String duration,
    required List<String> resources,
    required SubgoalStatusModel? status,
  }) = _SubgoalModel;

  factory SubgoalModel.fromJson(Map<String, dynamic> json) =>
      _$SubgoalModelFromJson(json);
}

extension SubgoalModelEntity on SubgoalModel {
  Subgoal toEntity() {
    return Subgoal(
      id: id ?? 'id ${DateTime.now().millisecondsSinceEpoch}',
      title: title,
      description: description,
      duration: duration,
      resources: resources,
      status: status?.toEntity(),
    );
  }
}

@freezed
abstract class SubgoalStatusModel with _$SubgoalStatusModel {
  factory SubgoalStatusModel({
    required bool completed,
    DateTime? completedAt,
    required String id,
  }) = _SubgoalStatusModel;

  factory SubgoalStatusModel.fromJson(Map<String, dynamic> json) =>
      _$SubgoalStatusModelFromJson(json);
}

extension SubgoalStatusModelEntity on SubgoalStatusModel {
  SubgoalStatus toEntity() {
    return SubgoalStatus(
      completed: completed,
      completedAt: completedAt,
      id: id,
    );
  }
}
