import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/features/auth/domain/usecases/is_user_logged_in/is_user_logged_in.dart';
import 'package:roadmap_ai/core/utils/no_params.dart';
import 'package:roadmap_ai/router/routes.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    checkValiditiyAndNavigate();
  }

  void checkValiditiyAndNavigate() async {
    final checkIsLoggedIn = await ref
        .read(isUserLoggedInProvider)
        .call(NoParams())
        .run();
    checkIsLoggedIn.fold(
      (failure) {
        context.goNamed(AppRoutes.auth);
      },
      (isLoggedIn) {
        if (isLoggedIn) {
          context.goNamed(AppRoutes.home);
        } else {
          context.goNamed(AppRoutes.auth);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoadingAnimationWidget.threeRotatingDots(
          color: context.colorScheme.primary,
          size: 30,
        ),
      ),
    );
  }
}
