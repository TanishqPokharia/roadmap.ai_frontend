import 'package:flutter/material.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';

class StatCounter extends StatefulWidget {
  const StatCounter({super.key, required this.value});
  final int value;
  @override
  State<StatCounter> createState() => _StatCounterState();
}

class _StatCounterState extends State<StatCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
      lowerBound: 0,
      upperBound: widget.value.toDouble(),
    )..forward();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Text(
          _controller.value.toInt().toString(),
          style: textTheme.headlineSmall!.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.primary,
          ),
        );
      },
    );
  }
}
