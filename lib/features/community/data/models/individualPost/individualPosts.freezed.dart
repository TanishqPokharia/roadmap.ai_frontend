// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'individualPosts.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IndividualPostResponse {

 Roadmap get roadmap;
/// Create a copy of IndividualPostResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IndividualPostResponseCopyWith<IndividualPostResponse> get copyWith => _$IndividualPostResponseCopyWithImpl<IndividualPostResponse>(this as IndividualPostResponse, _$identity);

  /// Serializes this IndividualPostResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IndividualPostResponse&&(identical(other.roadmap, roadmap) || other.roadmap == roadmap));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,roadmap);

@override
String toString() {
  return 'IndividualPostResponse(roadmap: $roadmap)';
}


}

/// @nodoc
abstract mixin class $IndividualPostResponseCopyWith<$Res>  {
  factory $IndividualPostResponseCopyWith(IndividualPostResponse value, $Res Function(IndividualPostResponse) _then) = _$IndividualPostResponseCopyWithImpl;
@useResult
$Res call({
 Roadmap roadmap
});


$RoadmapCopyWith<$Res> get roadmap;

}
/// @nodoc
class _$IndividualPostResponseCopyWithImpl<$Res>
    implements $IndividualPostResponseCopyWith<$Res> {
  _$IndividualPostResponseCopyWithImpl(this._self, this._then);

  final IndividualPostResponse _self;
  final $Res Function(IndividualPostResponse) _then;

/// Create a copy of IndividualPostResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? roadmap = null,}) {
  return _then(_self.copyWith(
roadmap: null == roadmap ? _self.roadmap : roadmap // ignore: cast_nullable_to_non_nullable
as Roadmap,
  ));
}
/// Create a copy of IndividualPostResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoadmapCopyWith<$Res> get roadmap {
  
  return $RoadmapCopyWith<$Res>(_self.roadmap, (value) {
    return _then(_self.copyWith(roadmap: value));
  });
}
}


/// Adds pattern-matching-related methods to [IndividualPostResponse].
extension IndividualPostResponsePatterns on IndividualPostResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IndividualPostResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IndividualPostResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IndividualPostResponse value)  $default,){
final _that = this;
switch (_that) {
case _IndividualPostResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IndividualPostResponse value)?  $default,){
final _that = this;
switch (_that) {
case _IndividualPostResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Roadmap roadmap)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IndividualPostResponse() when $default != null:
return $default(_that.roadmap);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Roadmap roadmap)  $default,) {final _that = this;
switch (_that) {
case _IndividualPostResponse():
return $default(_that.roadmap);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Roadmap roadmap)?  $default,) {final _that = this;
switch (_that) {
case _IndividualPostResponse() when $default != null:
return $default(_that.roadmap);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IndividualPostResponse implements IndividualPostResponse {
  const _IndividualPostResponse({required this.roadmap});
  factory _IndividualPostResponse.fromJson(Map<String, dynamic> json) => _$IndividualPostResponseFromJson(json);

@override final  Roadmap roadmap;

/// Create a copy of IndividualPostResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IndividualPostResponseCopyWith<_IndividualPostResponse> get copyWith => __$IndividualPostResponseCopyWithImpl<_IndividualPostResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IndividualPostResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IndividualPostResponse&&(identical(other.roadmap, roadmap) || other.roadmap == roadmap));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,roadmap);

@override
String toString() {
  return 'IndividualPostResponse(roadmap: $roadmap)';
}


}

/// @nodoc
abstract mixin class _$IndividualPostResponseCopyWith<$Res> implements $IndividualPostResponseCopyWith<$Res> {
  factory _$IndividualPostResponseCopyWith(_IndividualPostResponse value, $Res Function(_IndividualPostResponse) _then) = __$IndividualPostResponseCopyWithImpl;
@override @useResult
$Res call({
 Roadmap roadmap
});


@override $RoadmapCopyWith<$Res> get roadmap;

}
/// @nodoc
class __$IndividualPostResponseCopyWithImpl<$Res>
    implements _$IndividualPostResponseCopyWith<$Res> {
  __$IndividualPostResponseCopyWithImpl(this._self, this._then);

  final _IndividualPostResponse _self;
  final $Res Function(_IndividualPostResponse) _then;

/// Create a copy of IndividualPostResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? roadmap = null,}) {
  return _then(_IndividualPostResponse(
roadmap: null == roadmap ? _self.roadmap : roadmap // ignore: cast_nullable_to_non_nullable
as Roadmap,
  ));
}

/// Create a copy of IndividualPostResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoadmapCopyWith<$Res> get roadmap {
  
  return $RoadmapCopyWith<$Res>(_self.roadmap, (value) {
    return _then(_self.copyWith(roadmap: value));
  });
}
}


/// @nodoc
mixin _$Roadmap {

 String get userId; bool get isPosted; String get title; String get description; List<Goal> get goals; String get id;
/// Create a copy of Roadmap
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoadmapCopyWith<Roadmap> get copyWith => _$RoadmapCopyWithImpl<Roadmap>(this as Roadmap, _$identity);

  /// Serializes this Roadmap to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Roadmap&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.isPosted, isPosted) || other.isPosted == isPosted)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.goals, goals)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,isPosted,title,description,const DeepCollectionEquality().hash(goals),id);

@override
String toString() {
  return 'Roadmap(userId: $userId, isPosted: $isPosted, title: $title, description: $description, goals: $goals, id: $id)';
}


}

/// @nodoc
abstract mixin class $RoadmapCopyWith<$Res>  {
  factory $RoadmapCopyWith(Roadmap value, $Res Function(Roadmap) _then) = _$RoadmapCopyWithImpl;
@useResult
$Res call({
 String userId, bool isPosted, String title, String description, List<Goal> goals, String id
});




}
/// @nodoc
class _$RoadmapCopyWithImpl<$Res>
    implements $RoadmapCopyWith<$Res> {
  _$RoadmapCopyWithImpl(this._self, this._then);

  final Roadmap _self;
  final $Res Function(Roadmap) _then;

/// Create a copy of Roadmap
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? isPosted = null,Object? title = null,Object? description = null,Object? goals = null,Object? id = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,isPosted: null == isPosted ? _self.isPosted : isPosted // ignore: cast_nullable_to_non_nullable
as bool,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,goals: null == goals ? _self.goals : goals // ignore: cast_nullable_to_non_nullable
as List<Goal>,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Roadmap].
extension RoadmapPatterns on Roadmap {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Roadmap value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Roadmap() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Roadmap value)  $default,){
final _that = this;
switch (_that) {
case _Roadmap():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Roadmap value)?  $default,){
final _that = this;
switch (_that) {
case _Roadmap() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  bool isPosted,  String title,  String description,  List<Goal> goals,  String id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Roadmap() when $default != null:
return $default(_that.userId,_that.isPosted,_that.title,_that.description,_that.goals,_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  bool isPosted,  String title,  String description,  List<Goal> goals,  String id)  $default,) {final _that = this;
switch (_that) {
case _Roadmap():
return $default(_that.userId,_that.isPosted,_that.title,_that.description,_that.goals,_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  bool isPosted,  String title,  String description,  List<Goal> goals,  String id)?  $default,) {final _that = this;
switch (_that) {
case _Roadmap() when $default != null:
return $default(_that.userId,_that.isPosted,_that.title,_that.description,_that.goals,_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Roadmap implements Roadmap {
  const _Roadmap({required this.userId, required this.isPosted, required this.title, required this.description, required final  List<Goal> goals, required this.id}): _goals = goals;
  factory _Roadmap.fromJson(Map<String, dynamic> json) => _$RoadmapFromJson(json);

@override final  String userId;
@override final  bool isPosted;
@override final  String title;
@override final  String description;
 final  List<Goal> _goals;
@override List<Goal> get goals {
  if (_goals is EqualUnmodifiableListView) return _goals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_goals);
}

@override final  String id;

/// Create a copy of Roadmap
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoadmapCopyWith<_Roadmap> get copyWith => __$RoadmapCopyWithImpl<_Roadmap>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RoadmapToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Roadmap&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.isPosted, isPosted) || other.isPosted == isPosted)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._goals, _goals)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,isPosted,title,description,const DeepCollectionEquality().hash(_goals),id);

@override
String toString() {
  return 'Roadmap(userId: $userId, isPosted: $isPosted, title: $title, description: $description, goals: $goals, id: $id)';
}


}

/// @nodoc
abstract mixin class _$RoadmapCopyWith<$Res> implements $RoadmapCopyWith<$Res> {
  factory _$RoadmapCopyWith(_Roadmap value, $Res Function(_Roadmap) _then) = __$RoadmapCopyWithImpl;
@override @useResult
$Res call({
 String userId, bool isPosted, String title, String description, List<Goal> goals, String id
});




}
/// @nodoc
class __$RoadmapCopyWithImpl<$Res>
    implements _$RoadmapCopyWith<$Res> {
  __$RoadmapCopyWithImpl(this._self, this._then);

  final _Roadmap _self;
  final $Res Function(_Roadmap) _then;

/// Create a copy of Roadmap
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? isPosted = null,Object? title = null,Object? description = null,Object? goals = null,Object? id = null,}) {
  return _then(_Roadmap(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,isPosted: null == isPosted ? _self.isPosted : isPosted // ignore: cast_nullable_to_non_nullable
as bool,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,goals: null == goals ? _self._goals : goals // ignore: cast_nullable_to_non_nullable
as List<Goal>,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$Goal {

 String get title; List<SubGoal> get subgoals; String get id;
/// Create a copy of Goal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoalCopyWith<Goal> get copyWith => _$GoalCopyWithImpl<Goal>(this as Goal, _$identity);

  /// Serializes this Goal to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Goal&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.subgoals, subgoals)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,const DeepCollectionEquality().hash(subgoals),id);

@override
String toString() {
  return 'Goal(title: $title, subgoals: $subgoals, id: $id)';
}


}

/// @nodoc
abstract mixin class $GoalCopyWith<$Res>  {
  factory $GoalCopyWith(Goal value, $Res Function(Goal) _then) = _$GoalCopyWithImpl;
@useResult
$Res call({
 String title, List<SubGoal> subgoals, String id
});




}
/// @nodoc
class _$GoalCopyWithImpl<$Res>
    implements $GoalCopyWith<$Res> {
  _$GoalCopyWithImpl(this._self, this._then);

  final Goal _self;
  final $Res Function(Goal) _then;

/// Create a copy of Goal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? subgoals = null,Object? id = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subgoals: null == subgoals ? _self.subgoals : subgoals // ignore: cast_nullable_to_non_nullable
as List<SubGoal>,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Goal].
extension GoalPatterns on Goal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Goal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Goal() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Goal value)  $default,){
final _that = this;
switch (_that) {
case _Goal():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Goal value)?  $default,){
final _that = this;
switch (_that) {
case _Goal() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  List<SubGoal> subgoals,  String id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Goal() when $default != null:
return $default(_that.title,_that.subgoals,_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  List<SubGoal> subgoals,  String id)  $default,) {final _that = this;
switch (_that) {
case _Goal():
return $default(_that.title,_that.subgoals,_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  List<SubGoal> subgoals,  String id)?  $default,) {final _that = this;
switch (_that) {
case _Goal() when $default != null:
return $default(_that.title,_that.subgoals,_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Goal implements Goal {
  const _Goal({required this.title, required final  List<SubGoal> subgoals, required this.id}): _subgoals = subgoals;
  factory _Goal.fromJson(Map<String, dynamic> json) => _$GoalFromJson(json);

@override final  String title;
 final  List<SubGoal> _subgoals;
@override List<SubGoal> get subgoals {
  if (_subgoals is EqualUnmodifiableListView) return _subgoals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_subgoals);
}

@override final  String id;

/// Create a copy of Goal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GoalCopyWith<_Goal> get copyWith => __$GoalCopyWithImpl<_Goal>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GoalToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Goal&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._subgoals, _subgoals)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,const DeepCollectionEquality().hash(_subgoals),id);

@override
String toString() {
  return 'Goal(title: $title, subgoals: $subgoals, id: $id)';
}


}

/// @nodoc
abstract mixin class _$GoalCopyWith<$Res> implements $GoalCopyWith<$Res> {
  factory _$GoalCopyWith(_Goal value, $Res Function(_Goal) _then) = __$GoalCopyWithImpl;
@override @useResult
$Res call({
 String title, List<SubGoal> subgoals, String id
});




}
/// @nodoc
class __$GoalCopyWithImpl<$Res>
    implements _$GoalCopyWith<$Res> {
  __$GoalCopyWithImpl(this._self, this._then);

  final _Goal _self;
  final $Res Function(_Goal) _then;

/// Create a copy of Goal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? subgoals = null,Object? id = null,}) {
  return _then(_Goal(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subgoals: null == subgoals ? _self._subgoals : subgoals // ignore: cast_nullable_to_non_nullable
as List<SubGoal>,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SubGoal {

 String get title; String get description; String get duration; List<String> get resources; Status get status; String get id;
/// Create a copy of SubGoal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubGoalCopyWith<SubGoal> get copyWith => _$SubGoalCopyWithImpl<SubGoal>(this as SubGoal, _$identity);

  /// Serializes this SubGoal to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubGoal&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.duration, duration) || other.duration == duration)&&const DeepCollectionEquality().equals(other.resources, resources)&&(identical(other.status, status) || other.status == status)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,duration,const DeepCollectionEquality().hash(resources),status,id);

@override
String toString() {
  return 'SubGoal(title: $title, description: $description, duration: $duration, resources: $resources, status: $status, id: $id)';
}


}

/// @nodoc
abstract mixin class $SubGoalCopyWith<$Res>  {
  factory $SubGoalCopyWith(SubGoal value, $Res Function(SubGoal) _then) = _$SubGoalCopyWithImpl;
@useResult
$Res call({
 String title, String description, String duration, List<String> resources, Status status, String id
});


$StatusCopyWith<$Res> get status;

}
/// @nodoc
class _$SubGoalCopyWithImpl<$Res>
    implements $SubGoalCopyWith<$Res> {
  _$SubGoalCopyWithImpl(this._self, this._then);

  final SubGoal _self;
  final $Res Function(SubGoal) _then;

/// Create a copy of SubGoal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? description = null,Object? duration = null,Object? resources = null,Object? status = null,Object? id = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as String,resources: null == resources ? _self.resources : resources // ignore: cast_nullable_to_non_nullable
as List<String>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as Status,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of SubGoal
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatusCopyWith<$Res> get status {
  
  return $StatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}


/// Adds pattern-matching-related methods to [SubGoal].
extension SubGoalPatterns on SubGoal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubGoal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubGoal() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubGoal value)  $default,){
final _that = this;
switch (_that) {
case _SubGoal():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubGoal value)?  $default,){
final _that = this;
switch (_that) {
case _SubGoal() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String description,  String duration,  List<String> resources,  Status status,  String id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubGoal() when $default != null:
return $default(_that.title,_that.description,_that.duration,_that.resources,_that.status,_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String description,  String duration,  List<String> resources,  Status status,  String id)  $default,) {final _that = this;
switch (_that) {
case _SubGoal():
return $default(_that.title,_that.description,_that.duration,_that.resources,_that.status,_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String description,  String duration,  List<String> resources,  Status status,  String id)?  $default,) {final _that = this;
switch (_that) {
case _SubGoal() when $default != null:
return $default(_that.title,_that.description,_that.duration,_that.resources,_that.status,_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubGoal implements SubGoal {
  const _SubGoal({required this.title, required this.description, required this.duration, required final  List<String> resources, required this.status, required this.id}): _resources = resources;
  factory _SubGoal.fromJson(Map<String, dynamic> json) => _$SubGoalFromJson(json);

@override final  String title;
@override final  String description;
@override final  String duration;
 final  List<String> _resources;
@override List<String> get resources {
  if (_resources is EqualUnmodifiableListView) return _resources;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_resources);
}

@override final  Status status;
@override final  String id;

/// Create a copy of SubGoal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubGoalCopyWith<_SubGoal> get copyWith => __$SubGoalCopyWithImpl<_SubGoal>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubGoalToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubGoal&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.duration, duration) || other.duration == duration)&&const DeepCollectionEquality().equals(other._resources, _resources)&&(identical(other.status, status) || other.status == status)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,duration,const DeepCollectionEquality().hash(_resources),status,id);

@override
String toString() {
  return 'SubGoal(title: $title, description: $description, duration: $duration, resources: $resources, status: $status, id: $id)';
}


}

/// @nodoc
abstract mixin class _$SubGoalCopyWith<$Res> implements $SubGoalCopyWith<$Res> {
  factory _$SubGoalCopyWith(_SubGoal value, $Res Function(_SubGoal) _then) = __$SubGoalCopyWithImpl;
@override @useResult
$Res call({
 String title, String description, String duration, List<String> resources, Status status, String id
});


@override $StatusCopyWith<$Res> get status;

}
/// @nodoc
class __$SubGoalCopyWithImpl<$Res>
    implements _$SubGoalCopyWith<$Res> {
  __$SubGoalCopyWithImpl(this._self, this._then);

  final _SubGoal _self;
  final $Res Function(_SubGoal) _then;

/// Create a copy of SubGoal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = null,Object? duration = null,Object? resources = null,Object? status = null,Object? id = null,}) {
  return _then(_SubGoal(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as String,resources: null == resources ? _self._resources : resources // ignore: cast_nullable_to_non_nullable
as List<String>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as Status,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of SubGoal
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatusCopyWith<$Res> get status {
  
  return $StatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}


/// @nodoc
mixin _$Status {

 bool get completed; DateTime? get completedAt; String get id;
/// Create a copy of Status
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatusCopyWith<Status> get copyWith => _$StatusCopyWithImpl<Status>(this as Status, _$identity);

  /// Serializes this Status to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Status&&(identical(other.completed, completed) || other.completed == completed)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,completed,completedAt,id);

@override
String toString() {
  return 'Status(completed: $completed, completedAt: $completedAt, id: $id)';
}


}

/// @nodoc
abstract mixin class $StatusCopyWith<$Res>  {
  factory $StatusCopyWith(Status value, $Res Function(Status) _then) = _$StatusCopyWithImpl;
@useResult
$Res call({
 bool completed, DateTime? completedAt, String id
});




}
/// @nodoc
class _$StatusCopyWithImpl<$Res>
    implements $StatusCopyWith<$Res> {
  _$StatusCopyWithImpl(this._self, this._then);

  final Status _self;
  final $Res Function(Status) _then;

/// Create a copy of Status
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? completed = null,Object? completedAt = freezed,Object? id = null,}) {
  return _then(_self.copyWith(
completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as bool,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Status].
extension StatusPatterns on Status {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Status value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Status() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Status value)  $default,){
final _that = this;
switch (_that) {
case _Status():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Status value)?  $default,){
final _that = this;
switch (_that) {
case _Status() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool completed,  DateTime? completedAt,  String id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Status() when $default != null:
return $default(_that.completed,_that.completedAt,_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool completed,  DateTime? completedAt,  String id)  $default,) {final _that = this;
switch (_that) {
case _Status():
return $default(_that.completed,_that.completedAt,_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool completed,  DateTime? completedAt,  String id)?  $default,) {final _that = this;
switch (_that) {
case _Status() when $default != null:
return $default(_that.completed,_that.completedAt,_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Status implements Status {
  const _Status({required this.completed, this.completedAt, required this.id});
  factory _Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);

@override final  bool completed;
@override final  DateTime? completedAt;
@override final  String id;

/// Create a copy of Status
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatusCopyWith<_Status> get copyWith => __$StatusCopyWithImpl<_Status>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StatusToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Status&&(identical(other.completed, completed) || other.completed == completed)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,completed,completedAt,id);

@override
String toString() {
  return 'Status(completed: $completed, completedAt: $completedAt, id: $id)';
}


}

/// @nodoc
abstract mixin class _$StatusCopyWith<$Res> implements $StatusCopyWith<$Res> {
  factory _$StatusCopyWith(_Status value, $Res Function(_Status) _then) = __$StatusCopyWithImpl;
@override @useResult
$Res call({
 bool completed, DateTime? completedAt, String id
});




}
/// @nodoc
class __$StatusCopyWithImpl<$Res>
    implements _$StatusCopyWith<$Res> {
  __$StatusCopyWithImpl(this._self, this._then);

  final _Status _self;
  final $Res Function(_Status) _then;

/// Create a copy of Status
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? completed = null,Object? completedAt = freezed,Object? id = null,}) {
  return _then(_Status(
completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as bool,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
