import 'package:flutter/material.dart';
import 'package:roadmap_ai/core/common/widgets/animated_profile_menu_overlay.dart';

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
                  child: AnimatedProfileMenuOverlay(
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
