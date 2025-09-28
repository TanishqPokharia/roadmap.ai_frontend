import 'package:flutter/material.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';

class WebTopNavigationBar extends StatefulWidget {
  const WebTopNavigationBar({
    super.key,
    required this.items,
    required this.onItemSelected,
    required this.selectedIndex,
  });
  final List<WebTopNavigationItem> items;
  final void Function(int index) onItemSelected;
  final int selectedIndex;

  @override
  State<WebTopNavigationBar> createState() => _WebTopNavigationBarState();
}

class _WebTopNavigationBarState extends State<WebTopNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenWidth;
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Row(
        spacing: screenWidth * 0.02,
        children: [
          for (int i = 0; i < widget.items.length; i++)
            WebTopNavigationWidget(
              title: widget.items[i].title,
              isSelected: widget.selectedIndex == i,
              onItemSelected: () => widget.onItemSelected(i),
            ),
        ],
      ),
    );
  }
}

class WebTopNavigationWidget extends StatefulWidget {
  const WebTopNavigationWidget({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onItemSelected,
  });

  final String title;
  final bool isSelected;
  final void Function() onItemSelected;

  @override
  State<WebTopNavigationWidget> createState() => _WebTopNavigationWidgetState();
}

class _WebTopNavigationWidgetState extends State<WebTopNavigationWidget> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => widget.onItemSelected(),
        child: Row(
          children: [
            AnimatedDefaultTextStyle(
              curve: Curves.ease,
              duration: Durations.short4,
              style: widget.isSelected
                  ? textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold)
                  : _isHovered
                  ? textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600)
                  : textTheme.titleSmall!,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: _isHovered && !widget.isSelected ? 5 : 10,
                children: [
                  Text(widget.title),
                  if (widget.isSelected)
                    Container(
                      width: widget.title.length * 8.0,
                      height: 2,
                      color: context.colorScheme.primary,
                    ),
                  if (_isHovered && !widget.isSelected)
                    Container(
                      width: widget.title.length * 8.0,
                      height: 2,
                      color: context.colorScheme.primary.withAlpha(128),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WebTopNavigationItem {
  final String title;
  final IconData icon;

  WebTopNavigationItem({required this.title, required this.icon});
}
