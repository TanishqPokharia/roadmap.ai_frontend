// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GoalModel _$GoalModelFromJson(Map<String, dynamic> json) => _GoalModel(
  id: json['id'] as String?,
  title: json['title'] as String,
  subgoals: (json['subgoals'] as List<dynamic>)
      .map((e) => SubgoalModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$GoalModelToJson(_GoalModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subgoals': instance.subgoals,
    };
