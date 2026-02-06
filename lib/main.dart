import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadmap_ai/core/common/providers/theme_notifier.dart';
import 'package:roadmap_ai/core/themes/themes.dart';
import 'package:roadmap_ai/router/router_config.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ToastificationWrapper(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
        title: 'Roadmap.ai',
        theme: lightTheme,
        darkTheme: darkTheme,
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
