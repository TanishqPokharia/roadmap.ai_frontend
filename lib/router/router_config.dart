import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:roadmap_ai/core/common/entities/roadmap.dart';
import 'package:roadmap_ai/core/common/navigation_page.dart';
import 'package:roadmap_ai/features/auth/presentation/screens/auth_page.dart';
import 'package:roadmap_ai/features/auth/presentation/screens/splash_page.dart';
import 'package:roadmap_ai/features/community/presentation/screens/create_post_page.dart';
import 'package:roadmap_ai/features/community/presentation/screens/post_page.dart';
import 'package:roadmap_ai/router/routes.dart';

final class AppRouter {
  static GoRouter get router => _router;
  static final GoRouter _router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: '/',
        name: AppRoutes.splash,
        pageBuilder: (context, state) {
          return MaterialPage(child: const SplashPage());
        },
      ),
      GoRoute(
        path: '/auth',
        name: AppRoutes.auth,
        pageBuilder: (context, state) {
          return MaterialPage(child: const AuthPage());
        },
      ),
      GoRoute(
        path: '/home',
        name: AppRoutes.home,
        pageBuilder: (context, state) {
          return MaterialPage(child: NavigationPage());
        },
        routes: [
          GoRoute(
            path: '/post',
            name: AppRoutes.post,
            pageBuilder: (context, state) {
              final postId = state.uri.queryParameters['postId'];
              final title = state.uri.queryParameters['title'];
              return MaterialPage(
                child: PostPage(postId: postId!, title: title!),
              );
            },
          ),
          GoRoute(
            path: '/createPost',
            name: AppRoutes.createPost,
            pageBuilder: (context, state) {
              final roadmap = state.extra as Roadmap;
              return MaterialPage(child: CreatePostPage(roadmap: roadmap));
            },
          ),
        ],
      ),
    ],
  );
}
