import 'package:flutter/material.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';

class PostLikeButton extends StatefulWidget {
  const PostLikeButton({super.key, required this.likes});
  final int likes;

  @override
  State<PostLikeButton> createState() => _PostLikeButtonState();
}

class _PostLikeButtonState extends State<PostLikeButton> {
  bool _isHovered = false;
  bool _isLiked = false;
  late int _likes;

  @override
  void initState() {
    super.initState();
    _likes = widget.likes;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final screenHeight = context.screenHeight;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(_isHovered ? 1.3 : 1.0),
        child: Row(
          spacing: screenHeight * 0.005,
          children: [
            IconButton(
              icon: Icon(
                _isLiked ? Icons.favorite : Icons.favorite_border,
                color: _isLiked ? Colors.pink : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _isLiked = !_isLiked;
                  _likes += _isLiked ? 1 : -1;
                });
              },
              iconSize: 18,
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
            ),
            Text(
              '$_likes likes',
              style: textTheme.bodySmall!.copyWith(color: Colors.blueGrey),
            ),
          ],
        ),
      ),
    );
  }
}
