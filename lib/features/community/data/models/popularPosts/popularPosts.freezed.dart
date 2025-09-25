// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'popularPosts.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PopularPostResponse {

 List<Post> get posts;
/// Create a copy of PopularPostResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PopularPostResponseCopyWith<PopularPostResponse> get copyWith => _$PopularPostResponseCopyWithImpl<PopularPostResponse>(this as PopularPostResponse, _$identity);

  /// Serializes this PopularPostResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PopularPostResponse&&const DeepCollectionEquality().equals(other.posts, posts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(posts));

@override
String toString() {
  return 'PopularPostResponse(posts: $posts)';
}


}

/// @nodoc
abstract mixin class $PopularPostResponseCopyWith<$Res>  {
  factory $PopularPostResponseCopyWith(PopularPostResponse value, $Res Function(PopularPostResponse) _then) = _$PopularPostResponseCopyWithImpl;
@useResult
$Res call({
 List<Post> posts
});




}
/// @nodoc
class _$PopularPostResponseCopyWithImpl<$Res>
    implements $PopularPostResponseCopyWith<$Res> {
  _$PopularPostResponseCopyWithImpl(this._self, this._then);

  final PopularPostResponse _self;
  final $Res Function(PopularPostResponse) _then;

/// Create a copy of PopularPostResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? posts = null,}) {
  return _then(_self.copyWith(
posts: null == posts ? _self.posts : posts // ignore: cast_nullable_to_non_nullable
as List<Post>,
  ));
}

}


/// Adds pattern-matching-related methods to [PopularPostResponse].
extension PopularPostResponsePatterns on PopularPostResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PopularPostResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PopularPostResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PopularPostResponse value)  $default,){
final _that = this;
switch (_that) {
case _PopularPostResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PopularPostResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PopularPostResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Post> posts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PopularPostResponse() when $default != null:
return $default(_that.posts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Post> posts)  $default,) {final _that = this;
switch (_that) {
case _PopularPostResponse():
return $default(_that.posts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Post> posts)?  $default,) {final _that = this;
switch (_that) {
case _PopularPostResponse() when $default != null:
return $default(_that.posts);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PopularPostResponse implements PopularPostResponse {
  const _PopularPostResponse({required final  List<Post> posts}): _posts = posts;
  factory _PopularPostResponse.fromJson(Map<String, dynamic> json) => _$PopularPostResponseFromJson(json);

 final  List<Post> _posts;
@override List<Post> get posts {
  if (_posts is EqualUnmodifiableListView) return _posts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_posts);
}


/// Create a copy of PopularPostResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PopularPostResponseCopyWith<_PopularPostResponse> get copyWith => __$PopularPostResponseCopyWithImpl<_PopularPostResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PopularPostResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PopularPostResponse&&const DeepCollectionEquality().equals(other._posts, _posts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_posts));

@override
String toString() {
  return 'PopularPostResponse(posts: $posts)';
}


}

/// @nodoc
abstract mixin class _$PopularPostResponseCopyWith<$Res> implements $PopularPostResponseCopyWith<$Res> {
  factory _$PopularPostResponseCopyWith(_PopularPostResponse value, $Res Function(_PopularPostResponse) _then) = __$PopularPostResponseCopyWithImpl;
@override @useResult
$Res call({
 List<Post> posts
});




}
/// @nodoc
class __$PopularPostResponseCopyWithImpl<$Res>
    implements _$PopularPostResponseCopyWith<$Res> {
  __$PopularPostResponseCopyWithImpl(this._self, this._then);

  final _PopularPostResponse _self;
  final $Res Function(_PopularPostResponse) _then;

/// Create a copy of PopularPostResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? posts = null,}) {
  return _then(_PopularPostResponse(
posts: null == posts ? _self._posts : posts // ignore: cast_nullable_to_non_nullable
as List<Post>,
  ));
}


}


/// @nodoc
mixin _$Post {

 int get likes; String get bannerImage; int get views; DateTime get createdAt; int get v; String get id; String get title; String get description;
/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostCopyWith<Post> get copyWith => _$PostCopyWithImpl<Post>(this as Post, _$identity);

  /// Serializes this Post to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Post&&(identical(other.likes, likes) || other.likes == likes)&&(identical(other.bannerImage, bannerImage) || other.bannerImage == bannerImage)&&(identical(other.views, views) || other.views == views)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.v, v) || other.v == v)&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,likes,bannerImage,views,createdAt,v,id,title,description);

@override
String toString() {
  return 'Post(likes: $likes, bannerImage: $bannerImage, views: $views, createdAt: $createdAt, v: $v, id: $id, title: $title, description: $description)';
}


}

/// @nodoc
abstract mixin class $PostCopyWith<$Res>  {
  factory $PostCopyWith(Post value, $Res Function(Post) _then) = _$PostCopyWithImpl;
@useResult
$Res call({
 int likes, String bannerImage, int views, DateTime createdAt, int v, String id, String title, String description
});




}
/// @nodoc
class _$PostCopyWithImpl<$Res>
    implements $PostCopyWith<$Res> {
  _$PostCopyWithImpl(this._self, this._then);

  final Post _self;
  final $Res Function(Post) _then;

/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? likes = null,Object? bannerImage = null,Object? views = null,Object? createdAt = null,Object? v = null,Object? id = null,Object? title = null,Object? description = null,}) {
  return _then(_self.copyWith(
likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,bannerImage: null == bannerImage ? _self.bannerImage : bannerImage // ignore: cast_nullable_to_non_nullable
as String,views: null == views ? _self.views : views // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,v: null == v ? _self.v : v // ignore: cast_nullable_to_non_nullable
as int,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Post].
extension PostPatterns on Post {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Post value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Post() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Post value)  $default,){
final _that = this;
switch (_that) {
case _Post():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Post value)?  $default,){
final _that = this;
switch (_that) {
case _Post() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int likes,  String bannerImage,  int views,  DateTime createdAt,  int v,  String id,  String title,  String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Post() when $default != null:
return $default(_that.likes,_that.bannerImage,_that.views,_that.createdAt,_that.v,_that.id,_that.title,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int likes,  String bannerImage,  int views,  DateTime createdAt,  int v,  String id,  String title,  String description)  $default,) {final _that = this;
switch (_that) {
case _Post():
return $default(_that.likes,_that.bannerImage,_that.views,_that.createdAt,_that.v,_that.id,_that.title,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int likes,  String bannerImage,  int views,  DateTime createdAt,  int v,  String id,  String title,  String description)?  $default,) {final _that = this;
switch (_that) {
case _Post() when $default != null:
return $default(_that.likes,_that.bannerImage,_that.views,_that.createdAt,_that.v,_that.id,_that.title,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Post implements Post {
  const _Post({required this.likes, required this.bannerImage, required this.views, required this.createdAt, required this.v, required this.id, required this.title, required this.description});
  factory _Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

@override final  int likes;
@override final  String bannerImage;
@override final  int views;
@override final  DateTime createdAt;
@override final  int v;
@override final  String id;
@override final  String title;
@override final  String description;

/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostCopyWith<_Post> get copyWith => __$PostCopyWithImpl<_Post>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Post&&(identical(other.likes, likes) || other.likes == likes)&&(identical(other.bannerImage, bannerImage) || other.bannerImage == bannerImage)&&(identical(other.views, views) || other.views == views)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.v, v) || other.v == v)&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,likes,bannerImage,views,createdAt,v,id,title,description);

@override
String toString() {
  return 'Post(likes: $likes, bannerImage: $bannerImage, views: $views, createdAt: $createdAt, v: $v, id: $id, title: $title, description: $description)';
}


}

/// @nodoc
abstract mixin class _$PostCopyWith<$Res> implements $PostCopyWith<$Res> {
  factory _$PostCopyWith(_Post value, $Res Function(_Post) _then) = __$PostCopyWithImpl;
@override @useResult
$Res call({
 int likes, String bannerImage, int views, DateTime createdAt, int v, String id, String title, String description
});




}
/// @nodoc
class __$PostCopyWithImpl<$Res>
    implements _$PostCopyWith<$Res> {
  __$PostCopyWithImpl(this._self, this._then);

  final _Post _self;
  final $Res Function(_Post) _then;

/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? likes = null,Object? bannerImage = null,Object? views = null,Object? createdAt = null,Object? v = null,Object? id = null,Object? title = null,Object? description = null,}) {
  return _then(_Post(
likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,bannerImage: null == bannerImage ? _self.bannerImage : bannerImage // ignore: cast_nullable_to_non_nullable
as String,views: null == views ? _self.views : views // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,v: null == v ? _self.v : v // ignore: cast_nullable_to_non_nullable
as int,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
