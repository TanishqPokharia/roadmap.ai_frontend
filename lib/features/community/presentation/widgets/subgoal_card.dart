import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadmap_ai/core/common/entities/subgoal.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:url_launcher/link.dart';

class SubgoalCard extends ConsumerStatefulWidget {
  const SubgoalCard({
    super.key,
    required this.isExpanded,
    required this.subgoal,
  });
  final bool isExpanded;
  final Subgoal subgoal;

  @override
  ConsumerState<SubgoalCard> createState() => _SubgoalCardState();
}

class _SubgoalCardState extends ConsumerState<SubgoalCard> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;
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
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.withAlpha(26)),
          boxShadow: [
            if (_isHovered)
              BoxShadow(
                color: colorScheme.primary,
                blurRadius: 10,
                spreadRadius: 5,
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.subgoal.title,
                    style: textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
                Icon(
                  widget.isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  size: 18,
                  color: colorScheme.primary.withAlpha(153),
                ),
              ],
            ),

            // Initial preview (always visible)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                // Description (truncated when not expanded)
                Text(
                  widget.subgoal.description,
                  maxLines: widget.isExpanded ? null : 1,
                  overflow: widget.isExpanded ? null : TextOverflow.ellipsis,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface.withAlpha(179),
                  ),
                ),
              ],
            ),

            // Extended content (visible only when expanded)
            if (widget.isExpanded) ...[
              const SizedBox(height: 12),

              // Resources section
              if (widget.subgoal.resources.isNotEmpty) ...[
                Text(
                  'Resources:',
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                ...widget.subgoal.resources.map((resource) {
                  if (!resource.contains('http')) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4, left: 8),
                      child: Text("- $resource", style: textTheme.bodyMedium),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4, left: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.link,
                          size: textTheme.bodyMedium?.fontSize,
                          color: colorScheme.onPrimary,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Builder(
                            builder: (context) {
                              final urlStart = resource.indexOf('http');
                              final url = urlStart != -1
                                  ? resource
                                        .substring(urlStart)
                                        .split(' ')
                                        .first
                                  : resource;
                              return Link(
                                uri: Uri.parse(url),
                                target: LinkTarget.blank,
                                builder: (context, followLink) =>
                                    GestureDetector(
                                      onTap: followLink,
                                      child: Text(
                                        url,
                                        style: textTheme.bodyMedium?.copyWith(
                                          color: colorScheme.primaryContainer,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 20),
              ],
            ],

            SizedBox(height: 10),

            // Duration pill (always visible, at bottom)
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                widget.subgoal.duration,
                style: textTheme.labelLarge?.copyWith(
                  color: colorScheme.onSecondaryContainer,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
