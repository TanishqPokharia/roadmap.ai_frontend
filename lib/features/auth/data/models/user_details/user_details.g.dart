// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserDetailsModel _$UserDetailsModelFromJson(Map<String, dynamic> json) =>
    _UserDetailsModel(
      username: json['username'] as String,
      email: json['email'] as String,
      avatarUrl: json['avatarUrl'] as String,
    );

Map<String, dynamic> _$UserDetailsModelToJson(_UserDetailsModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'avatarUrl': instance.avatarUrl,
    };
