// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostMetadataModel {

 int get likes; PostAuthorModel get author; DateTime get createdAt; String get id; String get bannerImage; String get title; String get description; int get views;
/// Create a copy of PostMetadataModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostMetadataModelCopyWith<PostMetadataModel> get copyWith => _$PostMetadataModelCopyWithImpl<PostMetadataModel>(this as PostMetadataModel, _$identity);

  /// Serializes this PostMetadataModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostMetadataModel&&(identical(other.likes, likes) || other.likes == likes)&&(identical(other.author, author) || other.author == author)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.id, id) || other.id == id)&&(identical(other.bannerImage, bannerImage) || other.bannerImage == bannerImage)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.views, views) || other.views == views));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,likes,author,createdAt,id,bannerImage,title,description,views);

@override
String toString() {
  return 'PostMetadataModel(likes: $likes, author: $author, createdAt: $createdAt, id: $id, bannerImage: $bannerImage, title: $title, description: $description, views: $views)';
}


}

/// @nodoc
abstract mixin class $PostMetadataModelCopyWith<$Res>  {
  factory $PostMetadataModelCopyWith(PostMetadataModel value, $Res Function(PostMetadataModel) _then) = _$PostMetadataModelCopyWithImpl;
@useResult
$Res call({
 int likes, PostAuthorModel author, DateTime createdAt, String id, String bannerImage, String title, String description, int views
});


$PostAuthorModelCopyWith<$Res> get author;

}
/// @nodoc
class _$PostMetadataModelCopyWithImpl<$Res>
    implements $PostMetadataModelCopyWith<$Res> {
  _$PostMetadataModelCopyWithImpl(this._self, this._then);

  final PostMetadataModel _self;
  final $Res Function(PostMetadataModel) _then;

/// Create a copy of PostMetadataModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? likes = null,Object? author = null,Object? createdAt = null,Object? id = null,Object? bannerImage = null,Object? title = null,Object? description = null,Object? views = null,}) {
  return _then(_self.copyWith(
likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as PostAuthorModel,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bannerImage: null == bannerImage ? _self.bannerImage : bannerImage // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,views: null == views ? _self.views : views // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of PostMetadataModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostAuthorModelCopyWith<$Res> get author {
  
  return $PostAuthorModelCopyWith<$Res>(_self.author, (value) {
    return _then(_self.copyWith(author: value));
  });
}
}


/// Adds pattern-matching-related methods to [PostMetadataModel].
extension PostMetadataModelPatterns on PostMetadataModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostMetadataModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostMetadataModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostMetadataModel value)  $default,){
final _that = this;
switch (_that) {
case _PostMetadataModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostMetadataModel value)?  $default,){
final _that = this;
switch (_that) {
case _PostMetadataModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int likes,  PostAuthorModel author,  DateTime createdAt,  String id,  String bannerImage,  String title,  String description,  int views)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostMetadataModel() when $default != null:
return $default(_that.likes,_that.author,_that.createdAt,_that.id,_that.bannerImage,_that.title,_that.description,_that.views);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int likes,  PostAuthorModel author,  DateTime createdAt,  String id,  String bannerImage,  String title,  String description,  int views)  $default,) {final _that = this;
switch (_that) {
case _PostMetadataModel():
return $default(_that.likes,_that.author,_that.createdAt,_that.id,_that.bannerImage,_that.title,_that.description,_that.views);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int likes,  PostAuthorModel author,  DateTime createdAt,  String id,  String bannerImage,  String title,  String description,  int views)?  $default,) {final _that = this;
switch (_that) {
case _PostMetadataModel() when $default != null:
return $default(_that.likes,_that.author,_that.createdAt,_that.id,_that.bannerImage,_that.title,_that.description,_that.views);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostMetadataModel implements PostMetadataModel {
   _PostMetadataModel({required this.likes, required this.author, required this.createdAt, required this.id, required this.bannerImage, required this.title, required this.description, required this.views});
  factory _PostMetadataModel.fromJson(Map<String, dynamic> json) => _$PostMetadataModelFromJson(json);

@override final  int likes;
@override final  PostAuthorModel author;
@override final  DateTime createdAt;
@override final  String id;
@override final  String bannerImage;
@override final  String title;
@override final  String description;
@override final  int views;

/// Create a copy of PostMetadataModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostMetadataModelCopyWith<_PostMetadataModel> get copyWith => __$PostMetadataModelCopyWithImpl<_PostMetadataModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostMetadataModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostMetadataModel&&(identical(other.likes, likes) || other.likes == likes)&&(identical(other.author, author) || other.author == author)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.id, id) || other.id == id)&&(identical(other.bannerImage, bannerImage) || other.bannerImage == bannerImage)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.views, views) || other.views == views));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,likes,author,createdAt,id,bannerImage,title,description,views);

@override
String toString() {
  return 'PostMetadataModel(likes: $likes, author: $author, createdAt: $createdAt, id: $id, bannerImage: $bannerImage, title: $title, description: $description, views: $views)';
}


}

/// @nodoc
abstract mixin class _$PostMetadataModelCopyWith<$Res> implements $PostMetadataModelCopyWith<$Res> {
  factory _$PostMetadataModelCopyWith(_PostMetadataModel value, $Res Function(_PostMetadataModel) _then) = __$PostMetadataModelCopyWithImpl;
@override @useResult
$Res call({
 int likes, PostAuthorModel author, DateTime createdAt, String id, String bannerImage, String title, String description, int views
});


@override $PostAuthorModelCopyWith<$Res> get author;

}
/// @nodoc
class __$PostMetadataModelCopyWithImpl<$Res>
    implements _$PostMetadataModelCopyWith<$Res> {
  __$PostMetadataModelCopyWithImpl(this._self, this._then);

  final _PostMetadataModel _self;
  final $Res Function(_PostMetadataModel) _then;

/// Create a copy of PostMetadataModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? likes = null,Object? author = null,Object? createdAt = null,Object? id = null,Object? bannerImage = null,Object? title = null,Object? description = null,Object? views = null,}) {
  return _then(_PostMetadataModel(
likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as PostAuthorModel,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bannerImage: null == bannerImage ? _self.bannerImage : bannerImage // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,views: null == views ? _self.views : views // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of PostMetadataModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostAuthorModelCopyWith<$Res> get author {
  
  return $PostAuthorModelCopyWith<$Res>(_self.author, (value) {
    return _then(_self.copyWith(author: value));
  });
}
}

// dart format on
