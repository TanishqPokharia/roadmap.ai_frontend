// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostAuthorModel _$PostAuthorModelFromJson(Map<String, dynamic> json) =>
    _PostAuthorModel(
      username: json['username'] as String,
      email: json['email'] as String,
      avatar: json['avatar'] as String,
      id: json['id'] as String,
    );

Map<String, dynamic> _$PostAuthorModelToJson(_PostAuthorModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'avatar': instance.avatar,
      'id': instance.id,
    };
