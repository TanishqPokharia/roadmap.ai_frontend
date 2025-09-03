// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subgoal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubgoalModel _$SubgoalModelFromJson(Map<String, dynamic> json) =>
    _SubgoalModel(
      id: json['id'] as String?,
      title: json['title'] as String,
      description: json['description'] as String,
      duration: json['duration'] as String,
      resources: (json['resources'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      status: json['status'] == null
          ? null
          : SubgoalStatusModel.fromJson(json['status'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubgoalModelToJson(_SubgoalModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'duration': instance.duration,
      'resources': instance.resources,
      'status': instance.status,
    };

_SubgoalStatusModel _$SubgoalStatusModelFromJson(Map<String, dynamic> json) =>
    _SubgoalStatusModel(
      completed: json['completed'] as bool,
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      id: json['id'] as String,
    );

Map<String, dynamic> _$SubgoalStatusModelToJson(_SubgoalStatusModel instance) =>
    <String, dynamic>{
      'completed': instance.completed,
      'completedAt': instance.completedAt?.toIso8601String(),
      'id': instance.id,
    };
