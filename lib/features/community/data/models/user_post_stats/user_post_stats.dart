import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:roadmap_ai/features/community/domain/entities/user_post_stats.dart';

part 'user_post_stats.freezed.dart';
part 'user_post_stats.g.dart';

@freezed
abstract class UserPostStatsModel with _$UserPostStatsModel {
  factory UserPostStatsModel({
    required int totalPosts,
    required int totalLikes,
    required int totalViews,
  }) = _UserPostStatsModel;

  factory UserPostStatsModel.fromJson(Map<String, dynamic> json) =>
      _$UserPostStatsModelFromJson(json);
  factory UserPostStatsModel.fromEntity(UserPostStats stats) {
    return UserPostStatsModel(
      totalPosts: stats.totalPosts,
      totalLikes: stats.totalLikes,
      totalViews: stats.totalViews,
    );
  }
}

extension UserPostStatsModelEntity on UserPostStatsModel {
  UserPostStats toEntity() {
    return UserPostStats(
      totalPosts: totalPosts,
      totalLikes: totalLikes,
      totalViews: totalViews,
    );
  }
}
