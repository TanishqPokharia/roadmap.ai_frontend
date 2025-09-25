// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostDetailsModel {

 PostModel get post; bool get isSaved;
/// Create a copy of PostDetailsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostDetailsModelCopyWith<PostDetailsModel> get copyWith => _$PostDetailsModelCopyWithImpl<PostDetailsModel>(this as PostDetailsModel, _$identity);

  /// Serializes this PostDetailsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostDetailsModel&&(identical(other.post, post) || other.post == post)&&(identical(other.isSaved, isSaved) || other.isSaved == isSaved));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,post,isSaved);

@override
String toString() {
  return 'PostDetailsModel(post: $post, isSaved: $isSaved)';
}


}

/// @nodoc
abstract mixin class $PostDetailsModelCopyWith<$Res>  {
  factory $PostDetailsModelCopyWith(PostDetailsModel value, $Res Function(PostDetailsModel) _then) = _$PostDetailsModelCopyWithImpl;
@useResult
$Res call({
 PostModel post, bool isSaved
});


$PostModelCopyWith<$Res> get post;

}
/// @nodoc
class _$PostDetailsModelCopyWithImpl<$Res>
    implements $PostDetailsModelCopyWith<$Res> {
  _$PostDetailsModelCopyWithImpl(this._self, this._then);

  final PostDetailsModel _self;
  final $Res Function(PostDetailsModel) _then;

/// Create a copy of PostDetailsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? post = null,Object? isSaved = null,}) {
  return _then(_self.copyWith(
post: null == post ? _self.post : post // ignore: cast_nullable_to_non_nullable
as PostModel,isSaved: null == isSaved ? _self.isSaved : isSaved // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of PostDetailsModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostModelCopyWith<$Res> get post {
  
  return $PostModelCopyWith<$Res>(_self.post, (value) {
    return _then(_self.copyWith(post: value));
  });
}
}


/// Adds pattern-matching-related methods to [PostDetailsModel].
extension PostDetailsModelPatterns on PostDetailsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostDetailsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostDetailsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostDetailsModel value)  $default,){
final _that = this;
switch (_that) {
case _PostDetailsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostDetailsModel value)?  $default,){
final _that = this;
switch (_that) {
case _PostDetailsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PostModel post,  bool isSaved)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostDetailsModel() when $default != null:
return $default(_that.post,_that.isSaved);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PostModel post,  bool isSaved)  $default,) {final _that = this;
switch (_that) {
case _PostDetailsModel():
return $default(_that.post,_that.isSaved);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PostModel post,  bool isSaved)?  $default,) {final _that = this;
switch (_that) {
case _PostDetailsModel() when $default != null:
return $default(_that.post,_that.isSaved);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostDetailsModel implements PostDetailsModel {
   _PostDetailsModel({required this.post, required this.isSaved});
  factory _PostDetailsModel.fromJson(Map<String, dynamic> json) => _$PostDetailsModelFromJson(json);

@override final  PostModel post;
@override final  bool isSaved;

/// Create a copy of PostDetailsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostDetailsModelCopyWith<_PostDetailsModel> get copyWith => __$PostDetailsModelCopyWithImpl<_PostDetailsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostDetailsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostDetailsModel&&(identical(other.post, post) || other.post == post)&&(identical(other.isSaved, isSaved) || other.isSaved == isSaved));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,post,isSaved);

@override
String toString() {
  return 'PostDetailsModel(post: $post, isSaved: $isSaved)';
}


}

/// @nodoc
abstract mixin class _$PostDetailsModelCopyWith<$Res> implements $PostDetailsModelCopyWith<$Res> {
  factory _$PostDetailsModelCopyWith(_PostDetailsModel value, $Res Function(_PostDetailsModel) _then) = __$PostDetailsModelCopyWithImpl;
@override @useResult
$Res call({
 PostModel post, bool isSaved
});


@override $PostModelCopyWith<$Res> get post;

}
/// @nodoc
class __$PostDetailsModelCopyWithImpl<$Res>
    implements _$PostDetailsModelCopyWith<$Res> {
  __$PostDetailsModelCopyWithImpl(this._self, this._then);

  final _PostDetailsModel _self;
  final $Res Function(_PostDetailsModel) _then;

/// Create a copy of PostDetailsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? post = null,Object? isSaved = null,}) {
  return _then(_PostDetailsModel(
post: null == post ? _self.post : post // ignore: cast_nullable_to_non_nullable
as PostModel,isSaved: null == isSaved ? _self.isSaved : isSaved // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of PostDetailsModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostModelCopyWith<$Res> get post {
  
  return $PostModelCopyWith<$Res>(_self.post, (value) {
    return _then(_self.copyWith(post: value));
  });
}
}

// dart format on
