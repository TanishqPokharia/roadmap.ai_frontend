import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:roadmap_ai/core/common/entities/roadmap.dart';
import 'package:roadmap_ai/core/common/models/goal/goal.dart';

part 'roadmap.freezed.dart';
part 'roadmap.g.dart';

@freezed
abstract class RoadmapModel with _$RoadmapModel {
  factory RoadmapModel({
    required String? id,
    required String? userId,
    required String title,
    required List<GoalModel> goals,
    required String description,
  }) = _RoadmapModel;

  factory RoadmapModel.fromJson(Map<String, dynamic> json) =>
      _$RoadmapModelFromJson(json);
}

extension RoadmapModelEntity on RoadmapModel {
  Roadmap toEntity() {
    return Roadmap(
      id: id ?? 'id',
      userId: userId ?? 'userId',
      title: title,
      goals: goals.map((goal) => goal.toEntity()).toList(),
      description: description,
    );
  }
}
