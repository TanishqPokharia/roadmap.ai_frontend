// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'individualPosts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IndividualPostResponse _$IndividualPostResponseFromJson(
  Map<String, dynamic> json,
) => _IndividualPostResponse(
  roadmap: Roadmap.fromJson(json['roadmap'] as Map<String, dynamic>),
);

Map<String, dynamic> _$IndividualPostResponseToJson(
  _IndividualPostResponse instance,
) => <String, dynamic>{'roadmap': instance.roadmap};

_Roadmap _$RoadmapFromJson(Map<String, dynamic> json) => _Roadmap(
  userId: json['userId'] as String,
  isPosted: json['isPosted'] as bool,
  title: json['title'] as String,
  description: json['description'] as String,
  goals: (json['goals'] as List<dynamic>)
      .map((e) => Goal.fromJson(e as Map<String, dynamic>))
      .toList(),
  id: json['id'] as String,
);

Map<String, dynamic> _$RoadmapToJson(_Roadmap instance) => <String, dynamic>{
  'userId': instance.userId,
  'isPosted': instance.isPosted,
  'title': instance.title,
  'description': instance.description,
  'goals': instance.goals,
  'id': instance.id,
};

_Goal _$GoalFromJson(Map<String, dynamic> json) => _Goal(
  title: json['title'] as String,
  subgoals: (json['subgoals'] as List<dynamic>)
      .map((e) => SubGoal.fromJson(e as Map<String, dynamic>))
      .toList(),
  id: json['id'] as String,
);

Map<String, dynamic> _$GoalToJson(_Goal instance) => <String, dynamic>{
  'title': instance.title,
  'subgoals': instance.subgoals,
  'id': instance.id,
};

_SubGoal _$SubGoalFromJson(Map<String, dynamic> json) => _SubGoal(
  title: json['title'] as String,
  description: json['description'] as String,
  duration: json['duration'] as String,
  resources: (json['resources'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  status: Status.fromJson(json['status'] as Map<String, dynamic>),
  id: json['id'] as String,
);

Map<String, dynamic> _$SubGoalToJson(_SubGoal instance) => <String, dynamic>{
  'title': instance.title,
  'description': instance.description,
  'duration': instance.duration,
  'resources': instance.resources,
  'status': instance.status,
  'id': instance.id,
};

_Status _$StatusFromJson(Map<String, dynamic> json) => _Status(
  completed: json['completed'] as bool,
  completedAt: json['completedAt'] == null
      ? null
      : DateTime.parse(json['completedAt'] as String),
  id: json['id'] as String,
);

Map<String, dynamic> _$StatusToJson(_Status instance) => <String, dynamic>{
  'completed': instance.completed,
  'completedAt': instance.completedAt?.toIso8601String(),
  'id': instance.id,
};
