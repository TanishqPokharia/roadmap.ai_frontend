import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:roadmap_ai/features/auth/domain/usecases/is_user_logged_in.dart';
import 'package:roadmap_ai/utils/no_params.dart';

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
        context.go('/auth');
      },
      (isLoggedIn) {
        if (isLoggedIn) {
          context.go('/home');
        } else {
          context.go('/auth');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
