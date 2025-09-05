import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/features/auth/presentation/providers/logout/logout_notifier.dart';
import 'package:roadmap_ai/features/community/presentation/screens/explore_page.dart';
import 'package:roadmap_ai/features/community/presentation/screens/your_posts_page.dart';
import 'package:roadmap_ai/features/community/presentation/widgets/animated_menu_overlay.dart';
import 'package:roadmap_ai/features/roadmap/presentation/screens/create_roadmap_page.dart';
import 'package:roadmap_ai/features/roadmap/presentation/screens/saved_roadmaps_page.dart';
import 'package:roadmap_ai/core/themes/colors.dart';

class NavigationPage extends ConsumerStatefulWidget {
  const NavigationPage({super.key});

  @override
  ConsumerState<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends ConsumerState<NavigationPage> {
  int _selectedPageIndex = 0;
  final _pages = [
    ExplorePage(),
    YourPostsPage(),
    CreateRoadmapPage(),
    SavedRoadmapsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;
    final textTheme = context.textTheme;

    ref.listen(logoutNotifierProvider, (prev, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error.toString())));
      }

      if (next.hasValue && next.value == LogoutState.success) {
        context.go('/auth');
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Logged out successfully')));
      }
    });

    if (kIsWeb) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(width: screenHeight * 0.02),
              RichText(
                text: TextSpan(
                  text: 'Roadmap',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w900,
                    fontSize: textTheme.titleLarge!.fontSize,
                  ),
                  children: [
                    TextSpan(
                      text: '.ai',
                      style: GoogleFonts.inter(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w900,
                        fontSize: textTheme.titleLarge!.fontSize,
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
                    WebTopNavigationItem(
                      title: 'Saved',
                      icon: Icons.save_rounded,
                    ),
                  ],
                  onItemSelected: (index) {
                    setState(() {
                      _selectedPageIndex = index;
                    });
                  },
                  selectedIndex: _selectedPageIndex,
                ),
              ),
              if (_selectedPageIndex == 0)
                SizedBox(
                  width: screenWidth * 0.3,
                  height: screenHeight * 0.05,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      filled: true,
                      fillColor: buttonColor,
                      prefixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(width: screenHeight * 0.01),
                          Icon(Icons.search, color: colorScheme.onSurface),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              return SizedBox(
                                height: constraints.maxHeight * 0.5,
                                child: VerticalDivider(
                                  thickness: 1,
                                  color: colorScheme.onSurface.withAlpha(100),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              SizedBox(width: screenHeight * 0.02),
              ProfilePopupMenu(
                child: CircleAvatar(
                  backgroundColor: Colors.blueGrey,
                  child: Icon(Icons.person, size: 30, color: Colors.white),
                ),
              ),
              SizedBox(width: 16),
            ],
          ),
        ),
        body: _pages[_selectedPageIndex],
      );
    }
    return Scaffold();
  }
}

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

class ProfilePopupMenu extends StatefulWidget {
  final Widget child;

  const ProfilePopupMenu({super.key, required this.child});

  @override
  State<ProfilePopupMenu> createState() => _ProfilePopupMenuState();
}

class _ProfilePopupMenuState extends State<ProfilePopupMenu> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isMenuOpen = false;
  final GlobalKey<AnimatedMenuOverlayState> _animatedMenuKey =
      GlobalKey<AnimatedMenuOverlayState>();

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _removeOverlay() {
    if (_overlayEntry != null) {
      if (_isMenuOpen) {
        // Try to access the animated menu state through the key
        final animatedMenuState = _animatedMenuKey.currentState;

        if (animatedMenuState != null) {
          // Trigger the dismissal animation
          animatedMenuState.dismissMenu();
        } else {
          // Fallback if the state isn't available
          _overlayEntry!.remove();
          _overlayEntry = null;
          _isMenuOpen = false;
        }
      } else {
        _overlayEntry!.remove();
        _overlayEntry = null;
      }
    }
    _isMenuOpen = false;
  }

  void _toggleMenu() {
    if (_isMenuOpen) {
      _removeOverlay();
    } else {
      _showOverlay();
    }
  }

  void _showOverlay() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    _isMenuOpen = true;
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Material(
        color: Colors.transparent,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _removeOverlay,
          child: Stack(
            children: [
              Positioned(
                width: 280, // Increased width for better layout
                right:
                    16, // Match the SizedBox(width: 16) after ProfilePopupMenu
                top: 80, // Approximate height of the app bar
                child: CompositedTransformFollower(
                  link: _layerLink,
                  followerAnchor: Alignment.topRight,
                  targetAnchor: Alignment.bottomRight,
                  offset: const Offset(
                    0,
                    12,
                  ), // Increased offset for better visibility
                  child: AnimatedMenuOverlay(
                    key: _animatedMenuKey,
                    onDismiss: () {
                      // Only actually remove the overlay after animation completes
                      _overlayEntry?.remove();
                      _overlayEntry = null;
                      _isMenuOpen = false;
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(onTap: _toggleMenu, child: widget.child),
    );
  }
}
