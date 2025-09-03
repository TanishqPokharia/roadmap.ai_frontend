// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roadmap.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RoadmapModel _$RoadmapModelFromJson(Map<String, dynamic> json) =>
    _RoadmapModel(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      title: json['title'] as String,
      goals: (json['goals'] as List<dynamic>)
          .map((e) => GoalModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String,
    );

Map<String, dynamic> _$RoadmapModelToJson(_RoadmapModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'goals': instance.goals,
      'description': instance.description,
    };
