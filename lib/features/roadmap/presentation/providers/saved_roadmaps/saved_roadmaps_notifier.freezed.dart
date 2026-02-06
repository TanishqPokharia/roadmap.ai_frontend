// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_roadmaps_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SavedRoadmapsState {

 List<RoadmapMetadata> get roadmaps; bool get canGetMore; String? get error; bool get isFetching;
/// Create a copy of SavedRoadmapsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavedRoadmapsStateCopyWith<SavedRoadmapsState> get copyWith => _$SavedRoadmapsStateCopyWithImpl<SavedRoadmapsState>(this as SavedRoadmapsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavedRoadmapsState&&const DeepCollectionEquality().equals(other.roadmaps, roadmaps)&&(identical(other.canGetMore, canGetMore) || other.canGetMore == canGetMore)&&(identical(other.error, error) || other.error == error)&&(identical(other.isFetching, isFetching) || other.isFetching == isFetching));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(roadmaps),canGetMore,error,isFetching);

@override
String toString() {
  return 'SavedRoadmapsState(roadmaps: $roadmaps, canGetMore: $canGetMore, error: $error, isFetching: $isFetching)';
}


}

/// @nodoc
abstract mixin class $SavedRoadmapsStateCopyWith<$Res>  {
  factory $SavedRoadmapsStateCopyWith(SavedRoadmapsState value, $Res Function(SavedRoadmapsState) _then) = _$SavedRoadmapsStateCopyWithImpl;
@useResult
$Res call({
 List<RoadmapMetadata> roadmaps, bool canGetMore, String? error, bool isFetching
});




}
/// @nodoc
class _$SavedRoadmapsStateCopyWithImpl<$Res>
    implements $SavedRoadmapsStateCopyWith<$Res> {
  _$SavedRoadmapsStateCopyWithImpl(this._self, this._then);

  final SavedRoadmapsState _self;
  final $Res Function(SavedRoadmapsState) _then;

/// Create a copy of SavedRoadmapsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? roadmaps = null,Object? canGetMore = null,Object? error = freezed,Object? isFetching = null,}) {
  return _then(_self.copyWith(
roadmaps: null == roadmaps ? _self.roadmaps : roadmaps // ignore: cast_nullable_to_non_nullable
as List<RoadmapMetadata>,canGetMore: null == canGetMore ? _self.canGetMore : canGetMore // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,isFetching: null == isFetching ? _self.isFetching : isFetching // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SavedRoadmapsState].
extension SavedRoadmapsStatePatterns on SavedRoadmapsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SavedRoadmapsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SavedRoadmapsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SavedRoadmapsState value)  $default,){
final _that = this;
switch (_that) {
case _SavedRoadmapsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SavedRoadmapsState value)?  $default,){
final _that = this;
switch (_that) {
case _SavedRoadmapsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<RoadmapMetadata> roadmaps,  bool canGetMore,  String? error,  bool isFetching)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SavedRoadmapsState() when $default != null:
return $default(_that.roadmaps,_that.canGetMore,_that.error,_that.isFetching);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<RoadmapMetadata> roadmaps,  bool canGetMore,  String? error,  bool isFetching)  $default,) {final _that = this;
switch (_that) {
case _SavedRoadmapsState():
return $default(_that.roadmaps,_that.canGetMore,_that.error,_that.isFetching);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<RoadmapMetadata> roadmaps,  bool canGetMore,  String? error,  bool isFetching)?  $default,) {final _that = this;
switch (_that) {
case _SavedRoadmapsState() when $default != null:
return $default(_that.roadmaps,_that.canGetMore,_that.error,_that.isFetching);case _:
  return null;

}
}

}

/// @nodoc


class _SavedRoadmapsState implements SavedRoadmapsState {
  const _SavedRoadmapsState({required final  List<RoadmapMetadata> roadmaps, this.canGetMore = true, this.error, this.isFetching = false}): _roadmaps = roadmaps;
  

 final  List<RoadmapMetadata> _roadmaps;
@override List<RoadmapMetadata> get roadmaps {
  if (_roadmaps is EqualUnmodifiableListView) return _roadmaps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_roadmaps);
}

@override@JsonKey() final  bool canGetMore;
@override final  String? error;
@override@JsonKey() final  bool isFetching;

/// Create a copy of SavedRoadmapsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavedRoadmapsStateCopyWith<_SavedRoadmapsState> get copyWith => __$SavedRoadmapsStateCopyWithImpl<_SavedRoadmapsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavedRoadmapsState&&const DeepCollectionEquality().equals(other._roadmaps, _roadmaps)&&(identical(other.canGetMore, canGetMore) || other.canGetMore == canGetMore)&&(identical(other.error, error) || other.error == error)&&(identical(other.isFetching, isFetching) || other.isFetching == isFetching));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_roadmaps),canGetMore,error,isFetching);

@override
String toString() {
  return 'SavedRoadmapsState(roadmaps: $roadmaps, canGetMore: $canGetMore, error: $error, isFetching: $isFetching)';
}


}

/// @nodoc
abstract mixin class _$SavedRoadmapsStateCopyWith<$Res> implements $SavedRoadmapsStateCopyWith<$Res> {
  factory _$SavedRoadmapsStateCopyWith(_SavedRoadmapsState value, $Res Function(_SavedRoadmapsState) _then) = __$SavedRoadmapsStateCopyWithImpl;
@override @useResult
$Res call({
 List<RoadmapMetadata> roadmaps, bool canGetMore, String? error, bool isFetching
});




}
/// @nodoc
class __$SavedRoadmapsStateCopyWithImpl<$Res>
    implements _$SavedRoadmapsStateCopyWith<$Res> {
  __$SavedRoadmapsStateCopyWithImpl(this._self, this._then);

  final _SavedRoadmapsState _self;
  final $Res Function(_SavedRoadmapsState) _then;

/// Create a copy of SavedRoadmapsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? roadmaps = null,Object? canGetMore = null,Object? error = freezed,Object? isFetching = null,}) {
  return _then(_SavedRoadmapsState(
roadmaps: null == roadmaps ? _self._roadmaps : roadmaps // ignore: cast_nullable_to_non_nullable
as List<RoadmapMetadata>,canGetMore: null == canGetMore ? _self.canGetMore : canGetMore // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,isFetching: null == isFetching ? _self.isFetching : isFetching // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
