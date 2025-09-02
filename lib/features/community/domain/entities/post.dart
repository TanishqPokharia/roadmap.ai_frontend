import 'package:roadmap_ai/core/common/entities/roadmap.dart';

import 'author.dart';

class Post {
  final Roadmap roadmap;
  final String description;
  final int likes;
  final DateTime createdAt;
  final Author author;
  final String id;
  final String bannerUrl;

  const Post({
    required this.roadmap,
    required this.likes,
    required this.description,
    required this.createdAt,
    required this.author,
    required this.id,
    required this.bannerUrl,
  });
}
