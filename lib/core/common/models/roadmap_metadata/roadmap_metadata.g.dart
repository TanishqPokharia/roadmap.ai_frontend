// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roadmap_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RoadmapMetadataModel _$RoadmapMetadataModelFromJson(
  Map<String, dynamic> json,
) => _RoadmapMetadataModel(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  goalsCount: (json['goalsCount'] as num).toInt(),
  subgoalsCount: (json['subgoalsCount'] as num).toInt(),
  completedSubgoals: (json['completedSubgoals'] as num).toInt(),
  postId: json['postId'] as String?,
);

Map<String, dynamic> _$RoadmapMetadataModelToJson(
  _RoadmapMetadataModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'goalsCount': instance.goalsCount,
  'subgoalsCount': instance.subgoalsCount,
  'completedSubgoals': instance.completedSubgoals,
  'postId': instance.postId,
};
