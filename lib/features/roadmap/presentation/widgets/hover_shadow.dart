import 'package:flutter/material.dart';

class HoverShadow extends StatefulWidget {
  final Widget child;
  final Color shadowColor;
  final double blurRadius;
  final Offset offset;

  const HoverShadow({
    super.key,
    required this.child,
    required this.shadowColor,
    this.blurRadius = 20,
    this.offset = const Offset(0, 4),
  });

  @override
  State<HoverShadow> createState() => _HoverShadowState();
}

class _HoverShadowState extends State<HoverShadow> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: widget.shadowColor,
                    blurRadius: widget.blurRadius,
                    offset: widget.offset,
                  ),
                ]
              : [],
        ),
        child: widget.child,
      ),
    );
  }
}
