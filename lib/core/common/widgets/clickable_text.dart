import 'package:flutter/material.dart';

class ClickableText extends StatefulWidget {
  const ClickableText({
    super.key,
    required this.text,
    this.style,
    this.onClick,
  });
  final String text;
  final TextStyle? style;
  final void Function()? onClick;

  @override
  State<ClickableText> createState() => _ClickableTextState();
}

class _ClickableTextState extends State<ClickableText> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() => _isHovered = true),
      onExit: (event) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onClick,
        child: Text(
          widget.text,
          style: widget.style?.copyWith(
            decoration: _isHovered
                ? TextDecoration.underline
                : TextDecoration.none,
          ),
        ),
      ),
    );
  }
}
