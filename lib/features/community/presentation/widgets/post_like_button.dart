import 'package:flutter/material.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:vector_math/vector_math_64.dart' as v;

class PostLikeButton extends StatefulWidget {
  const PostLikeButton({
    super.key,
    required this.likes,
    required this.onLike,
    required this.isLiked,
  });
  final int likes;
  final bool isLiked;
  final VoidCallback onLike;

  @override
  State<PostLikeButton> createState() => _PostLikeButtonState();
}

class _PostLikeButtonState extends State<PostLikeButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final screenHeight = context.screenHeight;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        transform: Matrix4.identity()
          ..scaleByVector3(v.Vector3.all(_isHovered ? 1.3 : 1.0)),
        child: Row(
          spacing: screenHeight * 0.005,
          children: [
            IconButton(
              icon: Icon(
                widget.isLiked ? Icons.favorite : Icons.favorite_border,
                color: widget.isLiked ? Colors.pink : Colors.grey,
              ),
              onPressed: widget.onLike,
              iconSize: 18,
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
            ),
            Text(
              '${widget.likes} ${widget.likes == 1 ? "like" : "likes"}',
              style: textTheme.bodyLarge!.copyWith(color: Colors.blueGrey),
            ),
          ],
        ),
      ),
    );
  }
}
