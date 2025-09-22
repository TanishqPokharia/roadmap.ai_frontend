import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:roadmap_ai/features/community/data/models/author/author.dart';
import 'package:roadmap_ai/features/community/domain/entities/post_metadata.dart';

part 'post_metadata.freezed.dart';
part 'post_metadata.g.dart';

@freezed
abstract class PostMetadataModel with _$PostMetadataModel {
  factory PostMetadataModel({
    required int likes,
    required PostAuthorModel author,
    required DateTime createdAt,
    required String id,
    required String bannerImage,
    required String title,
    required String description,
    required int views,
  }) = _PostMetadataModel;

  factory PostMetadataModel.fromJson(Map<String, dynamic> json) =>
      _$PostMetadataModelFromJson(json);

  factory PostMetadataModel.fromEntity(PostMetadata postMetadata) {
    return PostMetadataModel(
      likes: postMetadata.likes,
      createdAt: postMetadata.createdAt,
      title: postMetadata.title,
      description: postMetadata.description,
      id: postMetadata.id,
      bannerImage: postMetadata.bannerImage,
      views: postMetadata.views,
      author: PostAuthorModel.fromEntity(postMetadata.author),
    );
  }
}

extension PostMetadataModelEntity on PostMetadataModel {
  PostMetadata toEntity() {
    return PostMetadata(
      likes: likes,
      createdAt: createdAt,
      id: id,
      bannerImage: bannerImage,
      title: title,
      description: description,
      views: views,
      author: author.toEntity(),
    );
  }
}
