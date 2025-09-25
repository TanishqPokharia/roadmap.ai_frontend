import 'package:freezed_annotation/freezed_annotation.dart';

part 'individualPosts.freezed.dart';
part 'individualPosts.g.dart';


@freezed
abstract class IndividualPostResponse with _$IndividualPostResponse {
  const factory IndividualPostResponse({
    required Roadmap roadmap
  }) = _IndividualPostResponse;

  factory IndividualPostResponse.fromJson(Map<String, dynamic> json) =>
      _$IndividualPostResponseFromJson(json);
}

@freezed
abstract class Roadmap with _$Roadmap {
  const factory Roadmap({
    required String userId,
    required bool isPosted,
    required String title,
    required String description,
    required List<Goal> goals,
    required String id,
  }) = _Roadmap;

  factory Roadmap.fromJson(Map<String, dynamic> json) =>
      _$RoadmapFromJson(json);
}

@freezed
abstract class Goal with _$Goal {
  const factory Goal({
    required String title,
    required List<SubGoal> subgoals,
    required String id,
  }) = _Goal;

  factory Goal.fromJson(Map<String, dynamic> json) => _$GoalFromJson(json);
}

@freezed
abstract class SubGoal with _$SubGoal {
  const factory SubGoal({
    required String title,
    required String description,
    required String duration,
    required List<String> resources,
    required Status status,
    required String id,
  }) = _SubGoal;

  factory SubGoal.fromJson(Map<String, dynamic> json) =>
      _$SubGoalFromJson(json);
}

@freezed
abstract class Status with _$Status {
  const factory Status({
    required bool completed,
    DateTime? completedAt,
    required String id,
  }) = _Status;

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);
}
