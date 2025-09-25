import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/popularPost.dart' as domain;

part 'popularPosts.freezed.dart';
part 'popularPosts.g.dart';

@freezed
abstract class PopularPostResponse with _$PopularPostResponse {
  const factory PopularPostResponse({
    required List<Post> posts,
  }) = _PopularPostResponse;

  factory PopularPostResponse.fromJson(Map<String, dynamic> json) =>
      _$PopularPostResponseFromJson(json);
}

@freezed
abstract class Post with _$Post {
  const factory Post({
    required int likes,
    required String bannerImage,
    required int views,
    required DateTime createdAt,
    required int v,
    required String id,
    required String title,
    required String description,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}


extension PopularPostResponseMapper on PopularPostResponse {
  domain.PopularPostResponse toDomain() {
    return domain.PopularPostResponse(
      posts: posts.map((p) => p.toDomain()).toList(),
    );
  }
}

extension PostMapper on Post {
  domain.Post toDomain() {
    return domain.Post(
      likes: likes,
      bannerImage: bannerImage,
      views: views,
      createdAt: createdAt,
      v: v,
      id: id,
      title: title,
      description: description,
    );
  }
}