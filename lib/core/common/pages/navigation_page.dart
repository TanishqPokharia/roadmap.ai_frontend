import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:roadmap_ai/core/common/widgets/web_app_bar.dart';
import 'package:roadmap_ai/core/common/providers/navigation_notifier.dart';
import 'package:roadmap_ai/features/auth/presentation/providers/logout/logout_notifier.dart';
import 'package:roadmap_ai/features/community/presentation/screens/explore_page.dart';
import 'package:roadmap_ai/features/community/presentation/screens/your_posts_page.dart';
import 'package:roadmap_ai/features/roadmap/presentation/screens/create_roadmap_page.dart';
import 'package:roadmap_ai/features/roadmap/presentation/screens/saved_roadmaps_page.dart';

class NavigationPage extends ConsumerStatefulWidget {
  const NavigationPage({super.key});

  @override
  ConsumerState<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends ConsumerState<NavigationPage> {
  final _pages = [
    ExplorePage(),
    YourPostsPage(),
    CreateRoadmapPage(),
    SavedRoadmapsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    final selectedPageIndex = ref.watch(navigationNotifierProvider);

    ref.listen(logoutNotifierProvider, (_, next) {
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

    if (kIsWeb) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: WebAppBar(),
        ),
        body: _pages[selectedPageIndex],
      );
    }
    return Scaffold();
  }
}
