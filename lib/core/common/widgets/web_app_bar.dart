import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadmap_ai/core/common/providers/navigation_notifier.dart';
import 'package:roadmap_ai/core/common/providers/theme_notifier.dart';
import 'package:roadmap_ai/core/common/widgets/profile_popup_menu.dart';
import 'package:roadmap_ai/core/common/widgets/web_top_navigation_bar.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/features/auth/presentation/providers/profile/profile_notifier.dart';

class WebAppBar extends ConsumerWidget {
  const WebAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = context.colorScheme;
    final screenHeight = context.screenHeight;
    final textTheme = context.textTheme;
    final selectedPageIndex = ref.watch(navigationNotifierProvider);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(width: screenHeight * 0.02),
        RichText(
          text: TextSpan(
            text: 'Roadmap',
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w900,
              color: textTheme.titleLarge?.color,
            ),
            children: [
              TextSpan(
                text: '.ai',
                style: textTheme.titleLarge?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: WebTopNavigationBar(
            items: [
              WebTopNavigationItem(title: 'Explore', icon: Icons.home),
              WebTopNavigationItem(
                title: 'Your Posts',
                icon: Icons.bookmark_added_outlined,
              ),
              WebTopNavigationItem(title: 'Create', icon: Icons.create),
              WebTopNavigationItem(title: 'Saved', icon: Icons.save_rounded),
            ],
            onItemSelected: (index) {
              ref
                  .read(navigationNotifierProvider.notifier)
                  .setSelectedIndex(index);
            },
            selectedIndex: selectedPageIndex,
          ),
        ),
        SizedBox(width: screenHeight * 0.02),
        ref
            .watch(themeNotifierProvider)
            .when(
              data: (themeMode) => PopupMenuButton<ThemeMode>(
                tooltip: 'Toggle Theme',
                icon: Icon(
                  themeMode == ThemeMode.dark
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_outlined,
                  size: 28,
                ),
                onSelected: (mode) {
                  ref.read(themeNotifierProvider.notifier).setTheme(mode);
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: ThemeMode.light,
                    child: Row(
                      children: [
                        Icon(
                          Icons.light_mode_outlined,
                          color: colorScheme.onSurface,
                        ),
                        SizedBox(width: screenHeight * 0.01),
                        Text('Light', style: textTheme.bodyMedium),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: ThemeMode.dark,
                    child: Row(
                      children: [
                        Icon(
                          Icons.dark_mode_outlined,
                          color: colorScheme.onSurface,
                        ),
                        SizedBox(width: screenHeight * 0.01),
                        Text('Dark', style: textTheme.bodyMedium),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: ThemeMode.system,
                    child: Row(
                      children: [
                        Icon(
                          Icons.brightness_auto_outlined,
                          color: colorScheme.onSurface,
                        ),
                        SizedBox(width: screenHeight * 0.01),
                        Text('System', style: textTheme.bodyMedium),
                      ],
                    ),
                  ),
                ],
              ),
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
        SizedBox(width: screenHeight * 0.02),
        ProfilePopupMenu(
          child: ref
              .watch(profileNotifierProvider)
              .when(
                data: (user) => CircleAvatar(
                  backgroundImage: NetworkImage(user.userDetails.avatarUrl),
                  radius: 24,
                  backgroundColor: colorScheme.primary,
                ),
                loading: () => const CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.grey,
                ),
                error: (_, __) => const CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.error, color: Colors.white),
                ),
              ),
        ),
        SizedBox(width: 16),
      ],
    );
  }
}
