import 'package:flutter/material.dart';

class AnimatedShadow extends StatefulWidget {
  const AnimatedShadow({
    super.key,
    required this.shadowColor,
    required this.child,
    required this.borderRadius,
  });
  final Color shadowColor;
  final Widget child;
  final BorderRadius borderRadius;

  @override
  State<AnimatedShadow> createState() => _AnimatedShadowState();
}

class _AnimatedShadowState extends State<AnimatedShadow> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() => _isHovered = true),
      onExit: (event) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: Durations.short4,
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
          boxShadow: [
            if (_isHovered)
              BoxShadow(
                color: widget.shadowColor,
                blurRadius: 10,
                spreadRadius: 2,
              ),
          ],
        ),
        child: widget.child,
      ),
    );
  }
}
