// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_post_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserPostStatsModel {

 int get totalPosts; int get totalLikes; int get totalViews;
/// Create a copy of UserPostStatsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserPostStatsModelCopyWith<UserPostStatsModel> get copyWith => _$UserPostStatsModelCopyWithImpl<UserPostStatsModel>(this as UserPostStatsModel, _$identity);

  /// Serializes this UserPostStatsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserPostStatsModel&&(identical(other.totalPosts, totalPosts) || other.totalPosts == totalPosts)&&(identical(other.totalLikes, totalLikes) || other.totalLikes == totalLikes)&&(identical(other.totalViews, totalViews) || other.totalViews == totalViews));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalPosts,totalLikes,totalViews);

@override
String toString() {
  return 'UserPostStatsModel(totalPosts: $totalPosts, totalLikes: $totalLikes, totalViews: $totalViews)';
}


}

/// @nodoc
abstract mixin class $UserPostStatsModelCopyWith<$Res>  {
  factory $UserPostStatsModelCopyWith(UserPostStatsModel value, $Res Function(UserPostStatsModel) _then) = _$UserPostStatsModelCopyWithImpl;
@useResult
$Res call({
 int totalPosts, int totalLikes, int totalViews
});




}
/// @nodoc
class _$UserPostStatsModelCopyWithImpl<$Res>
    implements $UserPostStatsModelCopyWith<$Res> {
  _$UserPostStatsModelCopyWithImpl(this._self, this._then);

  final UserPostStatsModel _self;
  final $Res Function(UserPostStatsModel) _then;

/// Create a copy of UserPostStatsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalPosts = null,Object? totalLikes = null,Object? totalViews = null,}) {
  return _then(_self.copyWith(
totalPosts: null == totalPosts ? _self.totalPosts : totalPosts // ignore: cast_nullable_to_non_nullable
as int,totalLikes: null == totalLikes ? _self.totalLikes : totalLikes // ignore: cast_nullable_to_non_nullable
as int,totalViews: null == totalViews ? _self.totalViews : totalViews // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [UserPostStatsModel].
extension UserPostStatsModelPatterns on UserPostStatsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserPostStatsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserPostStatsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserPostStatsModel value)  $default,){
final _that = this;
switch (_that) {
case _UserPostStatsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserPostStatsModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserPostStatsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalPosts,  int totalLikes,  int totalViews)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserPostStatsModel() when $default != null:
return $default(_that.totalPosts,_that.totalLikes,_that.totalViews);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalPosts,  int totalLikes,  int totalViews)  $default,) {final _that = this;
switch (_that) {
case _UserPostStatsModel():
return $default(_that.totalPosts,_that.totalLikes,_that.totalViews);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalPosts,  int totalLikes,  int totalViews)?  $default,) {final _that = this;
switch (_that) {
case _UserPostStatsModel() when $default != null:
return $default(_that.totalPosts,_that.totalLikes,_that.totalViews);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserPostStatsModel implements UserPostStatsModel {
   _UserPostStatsModel({required this.totalPosts, required this.totalLikes, required this.totalViews});
  factory _UserPostStatsModel.fromJson(Map<String, dynamic> json) => _$UserPostStatsModelFromJson(json);

@override final  int totalPosts;
@override final  int totalLikes;
@override final  int totalViews;

/// Create a copy of UserPostStatsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserPostStatsModelCopyWith<_UserPostStatsModel> get copyWith => __$UserPostStatsModelCopyWithImpl<_UserPostStatsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserPostStatsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserPostStatsModel&&(identical(other.totalPosts, totalPosts) || other.totalPosts == totalPosts)&&(identical(other.totalLikes, totalLikes) || other.totalLikes == totalLikes)&&(identical(other.totalViews, totalViews) || other.totalViews == totalViews));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalPosts,totalLikes,totalViews);

@override
String toString() {
  return 'UserPostStatsModel(totalPosts: $totalPosts, totalLikes: $totalLikes, totalViews: $totalViews)';
}


}

/// @nodoc
abstract mixin class _$UserPostStatsModelCopyWith<$Res> implements $UserPostStatsModelCopyWith<$Res> {
  factory _$UserPostStatsModelCopyWith(_UserPostStatsModel value, $Res Function(_UserPostStatsModel) _then) = __$UserPostStatsModelCopyWithImpl;
@override @useResult
$Res call({
 int totalPosts, int totalLikes, int totalViews
});




}
/// @nodoc
class __$UserPostStatsModelCopyWithImpl<$Res>
    implements _$UserPostStatsModelCopyWith<$Res> {
  __$UserPostStatsModelCopyWithImpl(this._self, this._then);

  final _UserPostStatsModel _self;
  final $Res Function(_UserPostStatsModel) _then;

/// Create a copy of UserPostStatsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalPosts = null,Object? totalLikes = null,Object? totalViews = null,}) {
  return _then(_UserPostStatsModel(
totalPosts: null == totalPosts ? _self.totalPosts : totalPosts // ignore: cast_nullable_to_non_nullable
as int,totalLikes: null == totalLikes ? _self.totalLikes : totalLikes // ignore: cast_nullable_to_non_nullable
as int,totalViews: null == totalViews ? _self.totalViews : totalViews // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
