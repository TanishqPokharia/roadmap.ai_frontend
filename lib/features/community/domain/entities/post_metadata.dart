import 'package:roadmap_ai/features/community/domain/entities/post_author.dart';

class PostMetadata {
  final int likes;
  final DateTime createdAt;
  final PostAuthor author;
  final String id;
  final String bannerImage;
  final String title;
  final String description;
  final int views;

  PostMetadata({
    required this.likes,
    required this.createdAt,
    required this.author,
    required this.title,
    required this.description,
    required this.id,
    required this.bannerImage,
    required this.views,
  });
}
