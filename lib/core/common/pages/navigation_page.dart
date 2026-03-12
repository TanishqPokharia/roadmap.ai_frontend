import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:roadmap_ai/core/common/widgets/web_app_bar.dart';
import 'package:roadmap_ai/core/common/providers/navigation_notifier.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/features/auth/presentation/providers/logout/logout_notifier.dart';
import 'package:roadmap_ai/features/auth/presentation/screens/profile_page.dart';
import 'package:roadmap_ai/features/community/presentation/screens/explore_page.dart';
import 'package:roadmap_ai/features/community/presentation/screens/your_posts_page.dart';
import 'package:roadmap_ai/features/roadmap/presentation/screens/create_roadmap_page.dart';
import 'package:roadmap_ai/features/roadmap/presentation/screens/saved_roadmaps_page.dart';

final selectedScreenIndexProvider = StateProvider.autoDispose<int>((ref) => 0);
final selectedNavbarIndexProvider = StateProvider.autoDispose<int>((ref) => 0);

class NavigationPage extends ConsumerStatefulWidget {
  const NavigationPage({super.key});

  @override
  ConsumerState<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends ConsumerState<NavigationPage> {
  late PageController _pageController;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final _pages = kIsWeb
      ? [
          ExplorePage(),
          YourPostsPage(),
          CreateRoadmapPage(),
          SavedRoadmapsPage(),
        ]
      : [
          ExplorePage(),
          YourPostsPage(),
          CreateRoadmapPage(),
          SavedRoadmapsPage(),
          ProfilePage(),
        ];
  @override
  Widget build(BuildContext context) {
    ref.listen(logoutProvider, (_, next) {
      if (next is AsyncError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error.toString())));
      }

      if (next is AsyncData && next.value == LogoutState.success) {
        context.go('/auth');
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Logged out successfully')));
      }
    });

    ref.listen(navigationProvider, (prev, next) {
      _pageController.animateToPage(
        next,
        duration: Duration(
          milliseconds: 300 * (prev != null ? (next - prev).abs() : next),
        ),
        curve: Curves.ease,
      );
    });

    final colorScheme = context.colorScheme;

    if (kIsWeb) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: WebAppBar(),
        ),
        body: PageView(
          controller: _pageController,
          children: _pages,
          // onPageChanged: (value) {
          //   ref
          //       .read(navigationNotifierProvider.notifier)
          //       .setSelectedIndex(value);
          // },
        ),
      );
    }

    if (!kIsWeb && Platform.isAndroid) {
      ref.listen(selectedScreenIndexProvider, (prev, next) {
        // update navbar state first
        ref.read(selectedNavbarIndexProvider.notifier).update((state) => next);

        // then update and animate the selected page
        if (!_isAnimating && _pageController.hasClients) {
          _isAnimating = true;
          _pageController
              .animateToPage(
                next,
                duration: Duration(
                  milliseconds: 300 * (next - (prev ?? 0)).abs(),
                ),
                curve: Curves.ease,
              )
              .then((_) {
                setState(() {
                  _isAnimating = false;
                });
              });
        }
      });
    }

    final selectedNavbarIndex = ref.watch(selectedNavbarIndexProvider);

    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (value) {
          if (!_isAnimating) {
            ref
                .read(selectedNavbarIndexProvider.notifier)
                .update((state) => value);
          }
        },
      ),
      bottomNavigationBar: GNav(
        color: colorScheme.primary,
        onTabChange: (value) {
          ref
              .read(selectedScreenIndexProvider.notifier)
              .update((state) => value);
        },
        selectedIndex: selectedNavbarIndex,
        gap: 4,
        activeColor: colorScheme.primaryContainer,
        tabMargin: EdgeInsetsGeometry.only(bottom: 30, left: 10, right: 10),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        tabBackgroundColor: colorScheme.primary,
        tabs: [
          GButton(icon: Icons.explore, text: 'Explore'),
          GButton(icon: Icons.article, text: 'Posts'),
          GButton(icon: Icons.add, text: 'Create'),
          GButton(icon: Icons.bookmark, text: 'Saved'),
          GButton(icon: Icons.account_circle, text: 'Profile'),
        ],
      ),
    );
  }
}
