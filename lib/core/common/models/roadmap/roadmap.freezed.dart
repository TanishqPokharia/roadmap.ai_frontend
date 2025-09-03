// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'roadmap.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RoadmapModel {

 String? get id; String? get userId; String get title; List<GoalModel> get goals; String get description;
/// Create a copy of RoadmapModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoadmapModelCopyWith<RoadmapModel> get copyWith => _$RoadmapModelCopyWithImpl<RoadmapModel>(this as RoadmapModel, _$identity);

  /// Serializes this RoadmapModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoadmapModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.goals, goals)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,title,const DeepCollectionEquality().hash(goals),description);

@override
String toString() {
  return 'RoadmapModel(id: $id, userId: $userId, title: $title, goals: $goals, description: $description)';
}


}

/// @nodoc
abstract mixin class $RoadmapModelCopyWith<$Res>  {
  factory $RoadmapModelCopyWith(RoadmapModel value, $Res Function(RoadmapModel) _then) = _$RoadmapModelCopyWithImpl;
@useResult
$Res call({
 String? id, String? userId, String title, List<GoalModel> goals, String description
});




}
/// @nodoc
class _$RoadmapModelCopyWithImpl<$Res>
    implements $RoadmapModelCopyWith<$Res> {
  _$RoadmapModelCopyWithImpl(this._self, this._then);

  final RoadmapModel _self;
  final $Res Function(RoadmapModel) _then;

/// Create a copy of RoadmapModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? userId = freezed,Object? title = null,Object? goals = null,Object? description = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,goals: null == goals ? _self.goals : goals // ignore: cast_nullable_to_non_nullable
as List<GoalModel>,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RoadmapModel].
extension RoadmapModelPatterns on RoadmapModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoadmapModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoadmapModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoadmapModel value)  $default,){
final _that = this;
switch (_that) {
case _RoadmapModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoadmapModel value)?  $default,){
final _that = this;
switch (_that) {
case _RoadmapModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? userId,  String title,  List<GoalModel> goals,  String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoadmapModel() when $default != null:
return $default(_that.id,_that.userId,_that.title,_that.goals,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? userId,  String title,  List<GoalModel> goals,  String description)  $default,) {final _that = this;
switch (_that) {
case _RoadmapModel():
return $default(_that.id,_that.userId,_that.title,_that.goals,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? userId,  String title,  List<GoalModel> goals,  String description)?  $default,) {final _that = this;
switch (_that) {
case _RoadmapModel() when $default != null:
return $default(_that.id,_that.userId,_that.title,_that.goals,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RoadmapModel implements RoadmapModel {
   _RoadmapModel({required this.id, required this.userId, required this.title, required final  List<GoalModel> goals, required this.description}): _goals = goals;
  factory _RoadmapModel.fromJson(Map<String, dynamic> json) => _$RoadmapModelFromJson(json);

@override final  String? id;
@override final  String? userId;
@override final  String title;
 final  List<GoalModel> _goals;
@override List<GoalModel> get goals {
  if (_goals is EqualUnmodifiableListView) return _goals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_goals);
}

@override final  String description;

/// Create a copy of RoadmapModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoadmapModelCopyWith<_RoadmapModel> get copyWith => __$RoadmapModelCopyWithImpl<_RoadmapModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RoadmapModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoadmapModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._goals, _goals)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,title,const DeepCollectionEquality().hash(_goals),description);

@override
String toString() {
  return 'RoadmapModel(id: $id, userId: $userId, title: $title, goals: $goals, description: $description)';
}


}

/// @nodoc
abstract mixin class _$RoadmapModelCopyWith<$Res> implements $RoadmapModelCopyWith<$Res> {
  factory _$RoadmapModelCopyWith(_RoadmapModel value, $Res Function(_RoadmapModel) _then) = __$RoadmapModelCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? userId, String title, List<GoalModel> goals, String description
});




}
/// @nodoc
class __$RoadmapModelCopyWithImpl<$Res>
    implements _$RoadmapModelCopyWith<$Res> {
  __$RoadmapModelCopyWithImpl(this._self, this._then);

  final _RoadmapModel _self;
  final $Res Function(_RoadmapModel) _then;

/// Create a copy of RoadmapModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? userId = freezed,Object? title = null,Object? goals = null,Object? description = null,}) {
  return _then(_RoadmapModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,goals: null == goals ? _self._goals : goals // ignore: cast_nullable_to_non_nullable
as List<GoalModel>,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
