import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:roadmap_ai/features/community/data/models/post/post.dart';
import 'package:roadmap_ai/features/community/domain/entities/post_details.dart';

part 'post_details.freezed.dart';
part 'post_details.g.dart';

@freezed
abstract class PostDetailsModel with _$PostDetailsModel {
  factory PostDetailsModel({required PostModel post, required bool isSaved}) =
      _PostDetailsModel;

  factory PostDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$PostDetailsModelFromJson(json);

  factory PostDetailsModel.fromEntity(PostDetails postDetails) {
    return PostDetailsModel(
      post: PostModel.fromEntity(postDetails.post),
      isSaved: postDetails.isSaved,
    );
  }
}

extension PostDetailsModelEntity on PostDetailsModel {
  PostDetails toEntity() {
    return PostDetails(post: post.toEntity(), isSaved: isSaved);
  }
}
