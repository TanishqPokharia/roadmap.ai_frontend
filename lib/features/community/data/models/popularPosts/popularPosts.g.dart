// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popularPosts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PopularPostResponse _$PopularPostResponseFromJson(Map<String, dynamic> json) =>
    _PopularPostResponse(
      posts: (json['posts'] as List<dynamic>)
          .map((e) => Post.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PopularPostResponseToJson(
  _PopularPostResponse instance,
) => <String, dynamic>{'posts': instance.posts};

_Post _$PostFromJson(Map<String, dynamic> json) => _Post(
  likes: (json['likes'] as num).toInt(),
  bannerImage: json['bannerImage'] as String,
  views: (json['views'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  v: (json['v'] as num).toInt(),
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
);

Map<String, dynamic> _$PostToJson(_Post instance) => <String, dynamic>{
  'likes': instance.likes,
  'bannerImage': instance.bannerImage,
  'views': instance.views,
  'createdAt': instance.createdAt.toIso8601String(),
  'v': instance.v,
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
};
