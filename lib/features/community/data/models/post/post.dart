import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:roadmap_ai/core/common/models/roadmap/roadmap.dart';
import 'package:roadmap_ai/features/community/data/models/author/author.dart';
import 'package:roadmap_ai/features/community/domain/entities/post.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
abstract class PostModel with _$PostModel {
  factory PostModel({
    required String id,
    required RoadmapModel roadmap,
    required String bannerImage,
    required PostAuthorModel author,
    required DateTime createdAt,
    required int likes,
    required int views,
  }) = _PostModel;

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  factory PostModel.fromEntity(Post post) {
    return PostModel(
      id: post.id,
      bannerImage: post.bannerImage,
      author: PostAuthorModel.fromEntity(post.author),
      createdAt: post.createdAt,
      likes: post.likes,
      views: post.views,
      roadmap: RoadmapModel.fromEntity(post.roadmap),
    );
  }
}

extension PostModelEntity on PostModel {
  Post toEntity() {
    return Post(
      id: id,
      roadmap: roadmap.toEntity(),
      title: roadmap.title,
      description: roadmap.description,
      bannerImage: bannerImage,
      author: author.toEntity(),
      createdAt: createdAt,
      likes: likes,
      views: views,
    );
  }
}
