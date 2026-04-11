import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:roadmap_ai/core/common/providers/theme_notifier.dart';
import 'package:roadmap_ai/core/constants/constants.dart';
import 'package:roadmap_ai/core/themes/themes.dart';
import 'package:roadmap_ai/features/auth/presentation/providers/login/login_notifier.dart';
import 'package:roadmap_ai/features/auth/presentation/providers/profile/profile_notifier.dart';
import 'package:roadmap_ai/features/auth/presentation/providers/signup/signup_notifier.dart';
import 'package:roadmap_ai/features/community/presentation/providers/posts/posts_notifier.dart';
import 'package:roadmap_ai/features/community/presentation/providers/posts_stats/posts_stats_notifier.dart';
import 'package:roadmap_ai/features/community/presentation/providers/user_posts/user_posts_notifier.dart';
import 'package:roadmap_ai/features/roadmap/presentation/providers/saved_roadmaps/saved_roadmaps_notifier.dart';
import 'package:roadmap_ai/router/router_config.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GoogleSignIn.instance.initialize(
    serverClientId: AppConstants.googleClientId,
  );
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  void _refreshProviderStates(WidgetRef ref) {
    ref.invalidate(postsProvider);
    ref.invalidate(userPostsProvider);
    ref.invalidate(userPostStatsProvider);
    ref.invalidate(savedRoadmapsProvider);
    ref.invalidate(profileProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(loginProvider, (prev, next) {
      if (prev?.asData?.value != LoginState.success &&
          next.asData?.value == LoginState.success) {
        _refreshProviderStates(ref);
      }
    });

    ref.listen(signupProvider, (prev, next) {
      if (prev?.asData?.value != SignUpState.success &&
          next.asData?.value == SignUpState.success) {
        _refreshProviderStates(ref);
      }
    });
    return ToastificationWrapper(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
        title: 'Roadmap.ai',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ref
            .watch(themeProvider)
            .maybeWhen(
              data: (themeMode) => themeMode,
              orElse: () => ThemeMode.system,
            ),
      ),
    );
  }
}
