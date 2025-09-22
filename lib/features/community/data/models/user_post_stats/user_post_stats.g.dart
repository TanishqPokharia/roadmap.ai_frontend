// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_post_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserPostStatsModel _$UserPostStatsModelFromJson(Map<String, dynamic> json) =>
    _UserPostStatsModel(
      totalPosts: (json['totalPosts'] as num).toInt(),
      totalLikes: (json['totalLikes'] as num).toInt(),
      totalViews: (json['totalViews'] as num).toInt(),
    );

Map<String, dynamic> _$UserPostStatsModelToJson(_UserPostStatsModel instance) =>
    <String, dynamic>{
      'totalPosts': instance.totalPosts,
      'totalLikes': instance.totalLikes,
      'totalViews': instance.totalViews,
    };
