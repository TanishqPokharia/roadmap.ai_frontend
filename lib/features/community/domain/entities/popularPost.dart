

class PopularPostResponse {
  final List<Post> posts;

  PopularPostResponse({
    required this.posts,
  });

  }

class Post {
  final int likes;
  final String bannerImage;
  final int views;
  final DateTime createdAt;
  final int v;
  final String id;
  final String title;
  final String description;

  const Post({
    required this.likes,
    required this.description,
    required this.title,
    required this.createdAt,
    required this.id,
    required this.views,
    required this.v,
    required this.bannerImage,
  });
}