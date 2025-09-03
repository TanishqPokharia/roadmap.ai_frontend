// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subgoal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubgoalModel {

 String? get id; String get title; String get description; String get duration; List<String> get resources; SubgoalStatusModel? get status;
/// Create a copy of SubgoalModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubgoalModelCopyWith<SubgoalModel> get copyWith => _$SubgoalModelCopyWithImpl<SubgoalModel>(this as SubgoalModel, _$identity);

  /// Serializes this SubgoalModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubgoalModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.duration, duration) || other.duration == duration)&&const DeepCollectionEquality().equals(other.resources, resources)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,duration,const DeepCollectionEquality().hash(resources),status);

@override
String toString() {
  return 'SubgoalModel(id: $id, title: $title, description: $description, duration: $duration, resources: $resources, status: $status)';
}


}

/// @nodoc
abstract mixin class $SubgoalModelCopyWith<$Res>  {
  factory $SubgoalModelCopyWith(SubgoalModel value, $Res Function(SubgoalModel) _then) = _$SubgoalModelCopyWithImpl;
@useResult
$Res call({
 String? id, String title, String description, String duration, List<String> resources, SubgoalStatusModel? status
});


$SubgoalStatusModelCopyWith<$Res>? get status;

}
/// @nodoc
class _$SubgoalModelCopyWithImpl<$Res>
    implements $SubgoalModelCopyWith<$Res> {
  _$SubgoalModelCopyWithImpl(this._self, this._then);

  final SubgoalModel _self;
  final $Res Function(SubgoalModel) _then;

/// Create a copy of SubgoalModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? title = null,Object? description = null,Object? duration = null,Object? resources = null,Object? status = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as String,resources: null == resources ? _self.resources : resources // ignore: cast_nullable_to_non_nullable
as List<String>,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SubgoalStatusModel?,
  ));
}
/// Create a copy of SubgoalModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubgoalStatusModelCopyWith<$Res>? get status {
    if (_self.status == null) {
    return null;
  }

  return $SubgoalStatusModelCopyWith<$Res>(_self.status!, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}


/// Adds pattern-matching-related methods to [SubgoalModel].
extension SubgoalModelPatterns on SubgoalModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubgoalModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubgoalModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubgoalModel value)  $default,){
final _that = this;
switch (_that) {
case _SubgoalModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubgoalModel value)?  $default,){
final _that = this;
switch (_that) {
case _SubgoalModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String title,  String description,  String duration,  List<String> resources,  SubgoalStatusModel? status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubgoalModel() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.duration,_that.resources,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String title,  String description,  String duration,  List<String> resources,  SubgoalStatusModel? status)  $default,) {final _that = this;
switch (_that) {
case _SubgoalModel():
return $default(_that.id,_that.title,_that.description,_that.duration,_that.resources,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String title,  String description,  String duration,  List<String> resources,  SubgoalStatusModel? status)?  $default,) {final _that = this;
switch (_that) {
case _SubgoalModel() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.duration,_that.resources,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubgoalModel implements SubgoalModel {
   _SubgoalModel({required this.id, required this.title, required this.description, required this.duration, required final  List<String> resources, required this.status}): _resources = resources;
  factory _SubgoalModel.fromJson(Map<String, dynamic> json) => _$SubgoalModelFromJson(json);

@override final  String? id;
@override final  String title;
@override final  String description;
@override final  String duration;
 final  List<String> _resources;
@override List<String> get resources {
  if (_resources is EqualUnmodifiableListView) return _resources;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_resources);
}

@override final  SubgoalStatusModel? status;

/// Create a copy of SubgoalModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubgoalModelCopyWith<_SubgoalModel> get copyWith => __$SubgoalModelCopyWithImpl<_SubgoalModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubgoalModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubgoalModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.duration, duration) || other.duration == duration)&&const DeepCollectionEquality().equals(other._resources, _resources)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,duration,const DeepCollectionEquality().hash(_resources),status);

@override
String toString() {
  return 'SubgoalModel(id: $id, title: $title, description: $description, duration: $duration, resources: $resources, status: $status)';
}


}

/// @nodoc
abstract mixin class _$SubgoalModelCopyWith<$Res> implements $SubgoalModelCopyWith<$Res> {
  factory _$SubgoalModelCopyWith(_SubgoalModel value, $Res Function(_SubgoalModel) _then) = __$SubgoalModelCopyWithImpl;
@override @useResult
$Res call({
 String? id, String title, String description, String duration, List<String> resources, SubgoalStatusModel? status
});


@override $SubgoalStatusModelCopyWith<$Res>? get status;

}
/// @nodoc
class __$SubgoalModelCopyWithImpl<$Res>
    implements _$SubgoalModelCopyWith<$Res> {
  __$SubgoalModelCopyWithImpl(this._self, this._then);

  final _SubgoalModel _self;
  final $Res Function(_SubgoalModel) _then;

/// Create a copy of SubgoalModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? title = null,Object? description = null,Object? duration = null,Object? resources = null,Object? status = freezed,}) {
  return _then(_SubgoalModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as String,resources: null == resources ? _self._resources : resources // ignore: cast_nullable_to_non_nullable
as List<String>,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SubgoalStatusModel?,
  ));
}

/// Create a copy of SubgoalModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubgoalStatusModelCopyWith<$Res>? get status {
    if (_self.status == null) {
    return null;
  }

  return $SubgoalStatusModelCopyWith<$Res>(_self.status!, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}


/// @nodoc
mixin _$SubgoalStatusModel {

 bool get completed; DateTime? get completedAt; String get id;
/// Create a copy of SubgoalStatusModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubgoalStatusModelCopyWith<SubgoalStatusModel> get copyWith => _$SubgoalStatusModelCopyWithImpl<SubgoalStatusModel>(this as SubgoalStatusModel, _$identity);

  /// Serializes this SubgoalStatusModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubgoalStatusModel&&(identical(other.completed, completed) || other.completed == completed)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,completed,completedAt,id);

@override
String toString() {
  return 'SubgoalStatusModel(completed: $completed, completedAt: $completedAt, id: $id)';
}


}

/// @nodoc
abstract mixin class $SubgoalStatusModelCopyWith<$Res>  {
  factory $SubgoalStatusModelCopyWith(SubgoalStatusModel value, $Res Function(SubgoalStatusModel) _then) = _$SubgoalStatusModelCopyWithImpl;
@useResult
$Res call({
 bool completed, DateTime? completedAt, String id
});




}
/// @nodoc
class _$SubgoalStatusModelCopyWithImpl<$Res>
    implements $SubgoalStatusModelCopyWith<$Res> {
  _$SubgoalStatusModelCopyWithImpl(this._self, this._then);

  final SubgoalStatusModel _self;
  final $Res Function(SubgoalStatusModel) _then;

/// Create a copy of SubgoalStatusModel
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


/// Adds pattern-matching-related methods to [SubgoalStatusModel].
extension SubgoalStatusModelPatterns on SubgoalStatusModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubgoalStatusModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubgoalStatusModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubgoalStatusModel value)  $default,){
final _that = this;
switch (_that) {
case _SubgoalStatusModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubgoalStatusModel value)?  $default,){
final _that = this;
switch (_that) {
case _SubgoalStatusModel() when $default != null:
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
case _SubgoalStatusModel() when $default != null:
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
case _SubgoalStatusModel():
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
case _SubgoalStatusModel() when $default != null:
return $default(_that.completed,_that.completedAt,_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubgoalStatusModel implements SubgoalStatusModel {
   _SubgoalStatusModel({required this.completed, this.completedAt, required this.id});
  factory _SubgoalStatusModel.fromJson(Map<String, dynamic> json) => _$SubgoalStatusModelFromJson(json);

@override final  bool completed;
@override final  DateTime? completedAt;
@override final  String id;

/// Create a copy of SubgoalStatusModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubgoalStatusModelCopyWith<_SubgoalStatusModel> get copyWith => __$SubgoalStatusModelCopyWithImpl<_SubgoalStatusModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubgoalStatusModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubgoalStatusModel&&(identical(other.completed, completed) || other.completed == completed)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,completed,completedAt,id);

@override
String toString() {
  return 'SubgoalStatusModel(completed: $completed, completedAt: $completedAt, id: $id)';
}


}

/// @nodoc
abstract mixin class _$SubgoalStatusModelCopyWith<$Res> implements $SubgoalStatusModelCopyWith<$Res> {
  factory _$SubgoalStatusModelCopyWith(_SubgoalStatusModel value, $Res Function(_SubgoalStatusModel) _then) = __$SubgoalStatusModelCopyWithImpl;
@override @useResult
$Res call({
 bool completed, DateTime? completedAt, String id
});




}
/// @nodoc
class __$SubgoalStatusModelCopyWithImpl<$Res>
    implements _$SubgoalStatusModelCopyWith<$Res> {
  __$SubgoalStatusModelCopyWithImpl(this._self, this._then);

  final _SubgoalStatusModel _self;
  final $Res Function(_SubgoalStatusModel) _then;

/// Create a copy of SubgoalStatusModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? completed = null,Object? completedAt = freezed,Object? id = null,}) {
  return _then(_SubgoalStatusModel(
completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as bool,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
