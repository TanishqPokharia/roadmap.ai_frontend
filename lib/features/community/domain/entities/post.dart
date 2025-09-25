import 'package:roadmap_ai/core/common/entities/roadmap.dart';

import 'post_author.dart';

class Post {
  final String title;
  final Roadmap roadmap;
  final String description;
  final int likes;
  final DateTime createdAt;
  final PostAuthor author;
  final String id;
  final String bannerImage;
  final int views;

  const Post({
    required this.title,
    required this.roadmap,
    required this.likes,
    required this.description,
    required this.createdAt,
    required this.author,
    required this.id,
    required this.bannerImage,
    required this.views,
  });
}
