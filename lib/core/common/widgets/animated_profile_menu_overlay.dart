import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/features/auth/domain/entities/user_details.dart';
import 'package:roadmap_ai/features/auth/presentation/providers/logout/logout_notifier.dart';
import 'package:roadmap_ai/features/auth/presentation/providers/profile/profile_notifier.dart';
import 'package:roadmap_ai/router/routes.dart';

class AnimatedProfileMenuOverlay extends ConsumerStatefulWidget {
  final VoidCallback onDismiss;

  const AnimatedProfileMenuOverlay({super.key, required this.onDismiss});

  @override
  AnimatedMenuOverlayState createState() => AnimatedMenuOverlayState();
}

class AnimatedMenuOverlayState extends ConsumerState<AnimatedProfileMenuOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    // Start the animation when the widget is built
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Made public so it can be called from the parent
  void dismissMenu() {
    _animationController.reverse().then((_) {
      if (mounted) {
        widget.onDismiss();
      }
    });
  }

  // Shows a confirmation dialog when logging out
  void _showLogoutConfirmationDialog(BuildContext context) {
    // First close the menu with animation
    dismissMenu();

    // Add a small delay to ensure the menu is closed before showing dialog
    Future.delayed(const Duration(milliseconds: 100), () {
      if (!context.mounted) return;

      // Then show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return _LogoutAlertDialog();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final profile = ref.watch(profileNotifierProvider);

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            alignment: Alignment.topRight,
            child: child,
          ),
        );
      },
      child: Material(
        elevation: 8.0, // Increased elevation for a more prominent appearance
        shadowColor: Colors.black.withAlpha(50),
        borderRadius: BorderRadius.circular(10), // Slightly rounded corners
        color: theme.cardColor,
        child: profile.when(
          loading: () => _LoadingContent(),
          error: (error, stack) => _ErrorContent(
            error: error.toString(),
            onRetry: () => ref.invalidate(profileNotifierProvider),
          ),
          data: (data) => _MenuContent(
            userDetails: data.userDetails,
            onLogoutTap: () => _showLogoutConfirmationDialog(context),
            onDismiss: dismissMenu,
          ),
        ),
      ),
    );
  }
}

class _LogoutAlertDialog extends ConsumerWidget {
  const _LogoutAlertDialog();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = context.colorScheme;
    return AlertDialog(
      icon: Icon(Icons.warning_outlined),
      iconColor: Colors.red,
      title: Text('Confirm Logout'),
      content: Text('Are you sure you want to logout?'),
      actions: [
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Use mounted instead of context.mounted since we're in a StatefulWidget
            ref.read(logoutNotifierProvider.notifier).logout();
            context.pop();
          },
          child: Text('Logout', style: TextStyle(color: colorScheme.error)),
        ),
      ],
    );
  }
}

class _MenuOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? textColor;
  final Color? iconColor;

  const _MenuOption({
    required this.icon,
    required this.title,
    required this.onTap,
    this.textColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: onTap,
        hoverColor: colorScheme.onSurface.withAlpha(20),
        splashColor: colorScheme.primary.withAlpha(30),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(icon, size: 20, color: iconColor),
              const SizedBox(width: 12),
              Text(
                title,
                style: textTheme.bodyMedium?.copyWith(color: textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadingContent extends StatelessWidget {
  const _LoadingContent();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 120,
      padding: const EdgeInsets.all(32.0),
      child: Center(child: CircularProgressIndicator(strokeWidth: 3)),
    );
  }
}

class _ErrorContent extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const _ErrorContent({required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;

    return Container(
      width: 280,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline, color: colorScheme.error, size: 32),
          const SizedBox(height: 12),
          Text(
            'Failed to load profile',
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            error,
            style: textTheme.bodySmall,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          TextButton(onPressed: onRetry, child: Text('Retry')),
        ],
      ),
    );
  }
}

class _MenuContent extends StatelessWidget {
  final UserDetails userDetails;
  final VoidCallback onLogoutTap;
  final VoidCallback onDismiss;

  const _MenuContent({
    required this.userDetails,
    required this.onLogoutTap,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Profile header with avatar and name
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(userDetails.avatarUrl),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userDetails.username,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      userDetails.email,
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface.withAlpha(150),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1),

        // Menu options
        _MenuOption(
          icon: Icons.person,
          title: 'My Profile',
          onTap: () {
            context.goNamed(AppRoutes.profile);
            onDismiss();
          },
        ),

        _MenuOption(
          icon: Icons.pie_chart,
          title: 'My Roadmaps',
          onTap: () {
            onDismiss();
            // Navigate to roadmaps
          },
        ),

        _MenuOption(
          icon: Icons.settings,
          title: 'Settings',
          onTap: () {
            onDismiss();
            // Navigate to settings
          },
        ),

        const Divider(height: 1),

        _MenuOption(
          icon: Icons.logout,
          title: 'Logout',
          onTap: onLogoutTap,
          textColor: colorScheme.error,
          iconColor: colorScheme.error,
        ),
      ],
    );
  }
}
