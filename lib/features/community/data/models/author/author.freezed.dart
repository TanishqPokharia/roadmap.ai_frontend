// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'author.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostAuthorModel {

 String get username; String get email; String get avatar; String get id;
/// Create a copy of PostAuthorModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostAuthorModelCopyWith<PostAuthorModel> get copyWith => _$PostAuthorModelCopyWithImpl<PostAuthorModel>(this as PostAuthorModel, _$identity);

  /// Serializes this PostAuthorModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostAuthorModel&&(identical(other.username, username) || other.username == username)&&(identical(other.email, email) || other.email == email)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,username,email,avatar,id);

@override
String toString() {
  return 'PostAuthorModel(username: $username, email: $email, avatar: $avatar, id: $id)';
}


}

/// @nodoc
abstract mixin class $PostAuthorModelCopyWith<$Res>  {
  factory $PostAuthorModelCopyWith(PostAuthorModel value, $Res Function(PostAuthorModel) _then) = _$PostAuthorModelCopyWithImpl;
@useResult
$Res call({
 String username, String email, String avatar, String id
});




}
/// @nodoc
class _$PostAuthorModelCopyWithImpl<$Res>
    implements $PostAuthorModelCopyWith<$Res> {
  _$PostAuthorModelCopyWithImpl(this._self, this._then);

  final PostAuthorModel _self;
  final $Res Function(PostAuthorModel) _then;

/// Create a copy of PostAuthorModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? username = null,Object? email = null,Object? avatar = null,Object? id = null,}) {
  return _then(_self.copyWith(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,avatar: null == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PostAuthorModel].
extension PostAuthorModelPatterns on PostAuthorModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostAuthorModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostAuthorModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostAuthorModel value)  $default,){
final _that = this;
switch (_that) {
case _PostAuthorModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostAuthorModel value)?  $default,){
final _that = this;
switch (_that) {
case _PostAuthorModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String username,  String email,  String avatar,  String id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostAuthorModel() when $default != null:
return $default(_that.username,_that.email,_that.avatar,_that.id);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String username,  String email,  String avatar,  String id)  $default,) {final _that = this;
switch (_that) {
case _PostAuthorModel():
return $default(_that.username,_that.email,_that.avatar,_that.id);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String username,  String email,  String avatar,  String id)?  $default,) {final _that = this;
switch (_that) {
case _PostAuthorModel() when $default != null:
return $default(_that.username,_that.email,_that.avatar,_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostAuthorModel implements PostAuthorModel {
   _PostAuthorModel({required this.username, required this.email, required this.avatar, required this.id});
  factory _PostAuthorModel.fromJson(Map<String, dynamic> json) => _$PostAuthorModelFromJson(json);

@override final  String username;
@override final  String email;
@override final  String avatar;
@override final  String id;

/// Create a copy of PostAuthorModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostAuthorModelCopyWith<_PostAuthorModel> get copyWith => __$PostAuthorModelCopyWithImpl<_PostAuthorModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostAuthorModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostAuthorModel&&(identical(other.username, username) || other.username == username)&&(identical(other.email, email) || other.email == email)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,username,email,avatar,id);

@override
String toString() {
  return 'PostAuthorModel(username: $username, email: $email, avatar: $avatar, id: $id)';
}


}

/// @nodoc
abstract mixin class _$PostAuthorModelCopyWith<$Res> implements $PostAuthorModelCopyWith<$Res> {
  factory _$PostAuthorModelCopyWith(_PostAuthorModel value, $Res Function(_PostAuthorModel) _then) = __$PostAuthorModelCopyWithImpl;
@override @useResult
$Res call({
 String username, String email, String avatar, String id
});




}
/// @nodoc
class __$PostAuthorModelCopyWithImpl<$Res>
    implements _$PostAuthorModelCopyWith<$Res> {
  __$PostAuthorModelCopyWithImpl(this._self, this._then);

  final _PostAuthorModel _self;
  final $Res Function(_PostAuthorModel) _then;

/// Create a copy of PostAuthorModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? username = null,Object? email = null,Object? avatar = null,Object? id = null,}) {
  return _then(_PostAuthorModel(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,avatar: null == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
