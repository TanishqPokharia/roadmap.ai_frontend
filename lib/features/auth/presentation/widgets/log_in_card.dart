import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/features/auth/presentation/providers/login/login_notifier.dart';
import 'package:roadmap_ai/router/routes.dart';
import 'package:roadmap_ai/themes/colors.dart';

class LogInCard extends ConsumerStatefulWidget {
  final VoidCallback? onSignUpTap;

  const LogInCard({super.key, this.onSignUpTap});

  @override
  ConsumerState<LogInCard> createState() => _LogInCardState();
}

class _LogInCardState extends ConsumerState<LogInCard> {
  bool _showPassword = false;
  @override
  Widget build(BuildContext context) {
    final screenHeight = context.screenHeight;
    final colorScheme = context.colorScheme;
    final screenWidth = context.screenWidth;
    final textTheme = context.textTheme;
    ref.listen(loginNotifierProvider, (previous, next) {
      next.whenOrNull(
        data: (data) {
          // show snackbar
          if (data == LoginState.success) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Login successful')));
            // navigate to home page
            context.goNamed(AppRoutes.home, queryParameters: {'test': 'true'});
          }
        },
        error: (error, stackTrace) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Login failed: $error')));
        },
      );
    });

    return Container(
      height: screenHeight,
      decoration: BoxDecoration(color: colorScheme.surfaceContainer),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.02),
        child: Center(
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              padding: EdgeInsets.all(screenWidth * 0.04),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white, Colors.white.withAlpha(230)],
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withAlpha(25),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.lock_person_rounded,
                      color: colorScheme.primary,
                      size: 32,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    'Welcome',
                    textAlign: TextAlign.center,
                    style: textTheme.headlineLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  SizedBox(height: screenHeight * 0.02),

                  // Email field
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: buttonColor,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: 'Email',
                      hintStyle: textTheme.bodyLarge!.copyWith(
                        color: Colors.blueGrey,
                      ),
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  // Password field
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: buttonColor,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: 'Password',
                      hintStyle: textTheme.bodyLarge!.copyWith(
                        color: Colors.blueGrey,
                      ),
                      prefixIcon: Icon(Icons.lock_outline),
                      suffixIcon: _showPassword
                          ? IconButton(
                              icon: Icon(Icons.visibility_outlined),
                              onPressed: () {
                                setState(() {
                                  _showPassword = false;
                                });
                              },
                            )
                          : IconButton(
                              icon: Icon(Icons.visibility_off_outlined),
                              onPressed: () {
                                setState(() {
                                  _showPassword = true;
                                });
                              },
                            ),
                    ),
                    obscureText: !_showPassword,
                  ),

                  SizedBox(height: screenHeight * 0.03),

                  // Login button
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return SizedBox(
                        width: constraints.maxWidth / 2,
                        height: screenHeight * 0.05,
                        child: Consumer(
                          builder: (context, ref, _) {
                            return ref
                                .watch(loginNotifierProvider)
                                .when(
                                  data: (data) {
                                    return FilledButton(
                                      onPressed: () {
                                        ref
                                            .read(
                                              loginNotifierProvider.notifier,
                                            )
                                            .login('', '');
                                      },
                                      child: Text(
                                        'Login',
                                        style: textTheme.titleMedium!.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  },
                                  error: (error, stackTrace) {
                                    return Text('Error: $error');
                                  },
                                  loading: () {
                                    return Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        color: colorScheme.primary,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(
                                        child: SizedBox(
                                          width: screenHeight * 0.025,
                                          height: screenHeight * 0.025,
                                          child:
                                              LoadingAnimationWidget.staggeredDotsWave(
                                                color: Colors.white,
                                                size: screenHeight * 0.025,
                                              ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                          },
                        ),
                      );
                    },
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  // Sign up option
                  Flexible(
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: textTheme.bodyMedium,
                        children: [
                          TextSpan(
                            text: 'Sign up',
                            style: textTheme.bodyMedium!.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = widget.onSignUpTap,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
