// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'roadmap_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RoadmapMetadataModel {

 String get id; String get title; String get description; int get goalsCount; int get subgoalsCount; int get completedSubgoals; bool get isPosted;
/// Create a copy of RoadmapMetadataModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoadmapMetadataModelCopyWith<RoadmapMetadataModel> get copyWith => _$RoadmapMetadataModelCopyWithImpl<RoadmapMetadataModel>(this as RoadmapMetadataModel, _$identity);

  /// Serializes this RoadmapMetadataModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoadmapMetadataModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.goalsCount, goalsCount) || other.goalsCount == goalsCount)&&(identical(other.subgoalsCount, subgoalsCount) || other.subgoalsCount == subgoalsCount)&&(identical(other.completedSubgoals, completedSubgoals) || other.completedSubgoals == completedSubgoals)&&(identical(other.isPosted, isPosted) || other.isPosted == isPosted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,goalsCount,subgoalsCount,completedSubgoals,isPosted);

@override
String toString() {
  return 'RoadmapMetadataModel(id: $id, title: $title, description: $description, goalsCount: $goalsCount, subgoalsCount: $subgoalsCount, completedSubgoals: $completedSubgoals, isPosted: $isPosted)';
}


}

/// @nodoc
abstract mixin class $RoadmapMetadataModelCopyWith<$Res>  {
  factory $RoadmapMetadataModelCopyWith(RoadmapMetadataModel value, $Res Function(RoadmapMetadataModel) _then) = _$RoadmapMetadataModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, int goalsCount, int subgoalsCount, int completedSubgoals, bool isPosted
});




}
/// @nodoc
class _$RoadmapMetadataModelCopyWithImpl<$Res>
    implements $RoadmapMetadataModelCopyWith<$Res> {
  _$RoadmapMetadataModelCopyWithImpl(this._self, this._then);

  final RoadmapMetadataModel _self;
  final $Res Function(RoadmapMetadataModel) _then;

/// Create a copy of RoadmapMetadataModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? goalsCount = null,Object? subgoalsCount = null,Object? completedSubgoals = null,Object? isPosted = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,goalsCount: null == goalsCount ? _self.goalsCount : goalsCount // ignore: cast_nullable_to_non_nullable
as int,subgoalsCount: null == subgoalsCount ? _self.subgoalsCount : subgoalsCount // ignore: cast_nullable_to_non_nullable
as int,completedSubgoals: null == completedSubgoals ? _self.completedSubgoals : completedSubgoals // ignore: cast_nullable_to_non_nullable
as int,isPosted: null == isPosted ? _self.isPosted : isPosted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RoadmapMetadataModel].
extension RoadmapMetadataModelPatterns on RoadmapMetadataModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoadmapMetadataModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoadmapMetadataModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoadmapMetadataModel value)  $default,){
final _that = this;
switch (_that) {
case _RoadmapMetadataModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoadmapMetadataModel value)?  $default,){
final _that = this;
switch (_that) {
case _RoadmapMetadataModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description,  int goalsCount,  int subgoalsCount,  int completedSubgoals,  bool isPosted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoadmapMetadataModel() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.goalsCount,_that.subgoalsCount,_that.completedSubgoals,_that.isPosted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description,  int goalsCount,  int subgoalsCount,  int completedSubgoals,  bool isPosted)  $default,) {final _that = this;
switch (_that) {
case _RoadmapMetadataModel():
return $default(_that.id,_that.title,_that.description,_that.goalsCount,_that.subgoalsCount,_that.completedSubgoals,_that.isPosted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description,  int goalsCount,  int subgoalsCount,  int completedSubgoals,  bool isPosted)?  $default,) {final _that = this;
switch (_that) {
case _RoadmapMetadataModel() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.goalsCount,_that.subgoalsCount,_that.completedSubgoals,_that.isPosted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RoadmapMetadataModel implements RoadmapMetadataModel {
   _RoadmapMetadataModel({required this.id, required this.title, required this.description, required this.goalsCount, required this.subgoalsCount, required this.completedSubgoals, required this.isPosted});
  factory _RoadmapMetadataModel.fromJson(Map<String, dynamic> json) => _$RoadmapMetadataModelFromJson(json);

@override final  String id;
@override final  String title;
@override final  String description;
@override final  int goalsCount;
@override final  int subgoalsCount;
@override final  int completedSubgoals;
@override final  bool isPosted;

/// Create a copy of RoadmapMetadataModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoadmapMetadataModelCopyWith<_RoadmapMetadataModel> get copyWith => __$RoadmapMetadataModelCopyWithImpl<_RoadmapMetadataModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RoadmapMetadataModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoadmapMetadataModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.goalsCount, goalsCount) || other.goalsCount == goalsCount)&&(identical(other.subgoalsCount, subgoalsCount) || other.subgoalsCount == subgoalsCount)&&(identical(other.completedSubgoals, completedSubgoals) || other.completedSubgoals == completedSubgoals)&&(identical(other.isPosted, isPosted) || other.isPosted == isPosted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,goalsCount,subgoalsCount,completedSubgoals,isPosted);

@override
String toString() {
  return 'RoadmapMetadataModel(id: $id, title: $title, description: $description, goalsCount: $goalsCount, subgoalsCount: $subgoalsCount, completedSubgoals: $completedSubgoals, isPosted: $isPosted)';
}


}

/// @nodoc
abstract mixin class _$RoadmapMetadataModelCopyWith<$Res> implements $RoadmapMetadataModelCopyWith<$Res> {
  factory _$RoadmapMetadataModelCopyWith(_RoadmapMetadataModel value, $Res Function(_RoadmapMetadataModel) _then) = __$RoadmapMetadataModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, int goalsCount, int subgoalsCount, int completedSubgoals, bool isPosted
});




}
/// @nodoc
class __$RoadmapMetadataModelCopyWithImpl<$Res>
    implements _$RoadmapMetadataModelCopyWith<$Res> {
  __$RoadmapMetadataModelCopyWithImpl(this._self, this._then);

  final _RoadmapMetadataModel _self;
  final $Res Function(_RoadmapMetadataModel) _then;

/// Create a copy of RoadmapMetadataModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? goalsCount = null,Object? subgoalsCount = null,Object? completedSubgoals = null,Object? isPosted = null,}) {
  return _then(_RoadmapMetadataModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,goalsCount: null == goalsCount ? _self.goalsCount : goalsCount // ignore: cast_nullable_to_non_nullable
as int,subgoalsCount: null == subgoalsCount ? _self.subgoalsCount : subgoalsCount // ignore: cast_nullable_to_non_nullable
as int,completedSubgoals: null == completedSubgoals ? _self.completedSubgoals : completedSubgoals // ignore: cast_nullable_to_non_nullable
as int,isPosted: null == isPosted ? _self.isPosted : isPosted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
