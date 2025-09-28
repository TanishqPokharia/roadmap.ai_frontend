import 'package:roadmap_ai/features/community/domain/entities/post.dart';

class PostDetails {
  final Post post;
  final bool isSaved;

  PostDetails({required this.post, required this.isSaved});
}
