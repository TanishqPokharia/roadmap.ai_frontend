import 'package:flutter/material.dart';

class AnimatedMenuOverlay extends StatefulWidget {
  final VoidCallback onDismiss;

  const AnimatedMenuOverlay({super.key, required this.onDismiss});

  @override
  AnimatedMenuOverlayState createState() => AnimatedMenuOverlayState();
}

class AnimatedMenuOverlayState extends State<AnimatedMenuOverlay>
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

    // Then show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: Icon(Icons.warning_outlined),
          iconColor: Colors.red,
          title: Text('Confirm Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Perform actual logout logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Logged out successfully!'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: Text(
                'Logout',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMenuOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? textColor,
    Color? iconColor,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: onTap,
        hoverColor: Theme.of(context).hoverColor,
        splashColor: Theme.of(context).splashColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(icon, size: 20, color: iconColor),
              const SizedBox(width: 12),
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
        color: Colors.transparent,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Main card with clean styling
            Material(
              elevation:
                  8.0, // Increased elevation for a more prominent appearance
              shadowColor: Colors.black.withAlpha(50),
              borderRadius: BorderRadius.circular(
                10,
              ), // Slightly rounded corners
              color: Theme.of(context).cardColor,
              child: Column(
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
                          backgroundImage: NetworkImage(
                            'https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg', // Placeholder avatar
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'John Doe', // Replace with actual username
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'john.doe@example.com', // Replace with actual email
                                style: Theme.of(context).textTheme.bodySmall,
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
                  _buildMenuOption(
                    context,
                    icon: Icons.person,
                    title: 'My Profile',
                    onTap: () {
                      dismissMenu();
                      // Navigate to profile page
                    },
                  ),

                  _buildMenuOption(
                    context,
                    icon: Icons.pie_chart,
                    title: 'My Roadmaps',
                    onTap: () {
                      dismissMenu();
                      // Navigate to roadmaps
                    },
                  ),

                  _buildMenuOption(
                    context,
                    icon: Icons.settings,
                    title: 'Settings',
                    onTap: () {
                      dismissMenu();
                      // Navigate to settings
                    },
                  ),

                  const Divider(height: 1),

                  _buildMenuOption(
                    context,
                    icon: Icons.logout,
                    title: 'Logout',
                    onTap: () {
                      // Show confirmation dialog before logging out
                      _showLogoutConfirmationDialog(context);
                    },
                    textColor: Theme.of(context).colorScheme.error,
                    iconColor: Theme.of(context).colorScheme.error,
                  ),
                ],
              ),
            ),

            // Triangle pointer removed as requested
          ],
        ),
      ),
    );
  }
}
