// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostMetadataModel _$PostMetadataModelFromJson(Map<String, dynamic> json) =>
    _PostMetadataModel(
      likes: (json['likes'] as num).toInt(),
      author: PostAuthorModel.fromJson(json['author'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      id: json['id'] as String,
      bannerImage: json['bannerImage'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      views: (json['views'] as num).toInt(),
    );

Map<String, dynamic> _$PostMetadataModelToJson(_PostMetadataModel instance) =>
    <String, dynamic>{
      'likes': instance.likes,
      'author': instance.author,
      'createdAt': instance.createdAt.toIso8601String(),
      'id': instance.id,
      'bannerImage': instance.bannerImage,
      'title': instance.title,
      'description': instance.description,
      'views': instance.views,
    };
