import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:roadmap_ai/core/common/entities/roadmap_metadata.dart';

part 'roadmap_metadata.freezed.dart';
part 'roadmap_metadata.g.dart';

@freezed
abstract class RoadmapMetadataModel with _$RoadmapMetadataModel {
  factory RoadmapMetadataModel({
    required String id,
    required String title,
    required String description,
    required int goalsCount,
    required int subgoalsCount,
    required int completedSubgoals,
    required String? postId,
  }) = _RoadmapMetadataModel;

  factory RoadmapMetadataModel.fromJson(Map<String, dynamic> json) =>
      _$RoadmapMetadataModelFromJson(json);

  factory RoadmapMetadataModel.fromEntity(RoadmapMetadata roadmapMetadata) {
    return RoadmapMetadataModel(
      id: roadmapMetadata.id,
      title: roadmapMetadata.title,
      description: roadmapMetadata.description,
      goalsCount: roadmapMetadata.goalsCount,
      subgoalsCount: roadmapMetadata.subgoalsCount,
      completedSubgoals: roadmapMetadata.completedSubgoals,
      postId: roadmapMetadata.postId,
    );
  }
}

extension RoadmapMetadataModelEntity on RoadmapMetadataModel {
  RoadmapMetadata toEntity() {
    return RoadmapMetadata(
      id: id,
      title: title,
      description: description,
      goalsCount: goalsCount,
      subgoalsCount: subgoalsCount,
      completedSubgoals: completedSubgoals,
      postId: postId,
    );
  }
}
