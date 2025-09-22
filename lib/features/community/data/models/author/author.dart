import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:roadmap_ai/features/community/domain/entities/post_author.dart';

part 'author.freezed.dart';
part 'author.g.dart';

@freezed
abstract class PostAuthorModel with _$PostAuthorModel {
  factory PostAuthorModel({
    required String username,
    required String email,
    required String avatar,
    required String id,
  }) = _PostAuthorModel;

  factory PostAuthorModel.fromJson(Map<String, dynamic> json) =>
      _$PostAuthorModelFromJson(json);

  factory PostAuthorModel.fromEntity(PostAuthor author) {
    return PostAuthorModel(
      username: author.username,
      email: author.email,
      avatar: author.avatar,
      id: author.id,
    );
  }
}

extension PostAuthorModelEntity on PostAuthorModel {
  PostAuthor toEntity() {
    return PostAuthor(username: username, email: email, avatar: avatar, id: id);
  }
}
