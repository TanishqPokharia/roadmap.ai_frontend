// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostDetailsModel _$PostDetailsModelFromJson(Map<String, dynamic> json) =>
    _PostDetailsModel(
      post: PostModel.fromJson(json['post'] as Map<String, dynamic>),
      isSaved: json['isSaved'] as bool,
    );

Map<String, dynamic> _$PostDetailsModelToJson(_PostDetailsModel instance) =>
    <String, dynamic>{'post': instance.post, 'isSaved': instance.isSaved};
