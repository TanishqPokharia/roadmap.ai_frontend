import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roadmap_ai/core/common/toast/error.dart';
import 'package:roadmap_ai/core/common/toast/success.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/core/utils/failures.dart';
import 'package:roadmap_ai/features/auth/presentation/providers/login/login_notifier.dart';
import 'package:roadmap_ai/features/auth/presentation/providers/signup/signup_notifier.dart';
import 'package:roadmap_ai/features/auth/presentation/widgets/feature_item.dart';
import 'package:roadmap_ai/features/auth/presentation/widgets/log_in_card.dart';
import 'package:roadmap_ai/features/auth/presentation/widgets/sign_up_card.dart';

class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({super.key});

  @override
  ConsumerState<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage> {
  bool _showSignUp = false;
  bool _showTaglines = false;

  void _toggleAuthMode() {
    setState(() {
      _showSignUp = !_showSignUp;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final theme = context.theme;
    final colorScheme = context.colorScheme;
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;

    final tagLines = [
      'Get personalized AI powered roadmaps for every skill or goal within seconds.',
      'Personalized learning and global community support - All at one place.',
      'Join a community of learners and achieve your goals faster.',
    ];

    ref.listen(loginProvider, (_, next) {
      if (next is AsyncError) {
        showErrorToast(
          context: context,
          error: (next.error as Failure).message.toString(),
        );
      }

      if (next is AsyncData && next.value != LoginState.initial) {
        showSuccessToast(context: context, success: 'Logged in successfully');
        context.go('/home');
      }
    });
    ref.listen(signupProvider, (_, next) {
      if (next is AsyncError) {
        showErrorToast(
          context: context,
          error: (next.error as Failure).message.toString(),
        );
      }

      if (next is AsyncData && next.value != SignUpState.initial) {
        showSuccessToast(context: context, success: 'Signed up successfully!');
        context.go('/home');
      }
    });

    if (!kIsWeb && Platform.isAndroid) {
      return Scaffold(
        body: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: AlignmentGeometry.topCenter,
              end: Alignment.bottomCenter,
              colors: [colorScheme.primaryContainer, colorScheme.primary],
            ),
          ),
          child: SizedBox(
            height: screenHeight,
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 60),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Animate(
                          onComplete: (controller) {
                            setState(() {
                              _showTaglines = true;
                            });
                          },
                          effects: [
                            FadeEffect(
                              duration: Durations.extralong4,
                              curve: Curves.ease,
                            ),
                            MoveEffect(
                              duration: Durations.extralong4,
                              begin: Offset(-20, 0),
                              end: Offset(0, 0),
                              curve: Curves.ease,
                            ),
                          ],
                          child: Row(
                            spacing: 10,
                            children: [
                              Stack(
                                alignment: AlignmentGeometry.bottomRight,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Image.asset(
                                      "assets/roadmap.png",
                                      height: 60,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Image.asset(
                                      "assets/generate.png",
                                      height: 30,
                                    ),
                                  ),
                                ],
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'Roadmap',
                                  style: textTheme.displayMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '.ai',
                                      style: textTheme.displayMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: colorScheme.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Visibility(
                      visible: _showTaglines,
                      replacement: SizedBox(height: screenHeight * 0.1),
                      child: SizedBox(
                        height: screenHeight * 0.1,
                        child: AnimatedTextKit(
                          pause: Duration(seconds: 2),
                          repeatForever: true,
                          animatedTexts: tagLines
                              .map(
                                (text) => TypewriterAnimatedText(
                                  text,
                                  textAlign: TextAlign.center,
                                  speed: Duration(milliseconds: 40),
                                  textStyle: textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  cursor: '|',
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Animate(
                      effects: [
                        SlideEffect(
                          delay: Duration(milliseconds: 500),
                          begin: Offset(0, 1.5),
                          end: Offset.zero,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        ),
                      ],
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 500),
                        reverseDuration: Duration(milliseconds: 500),
                        transitionBuilder: (child, animation) {
                          return SlideTransition(
                            position:
                                Tween<Offset>(
                                      begin: Offset(1, 0),
                                      end: Offset.zero,
                                    )
                                    .chain(CurveTween(curve: Curves.ease))
                                    .animate(animation),
                            child: child,
                          );
                        },
                        layoutBuilder: (currentChild, previousChildren) {
                          return Stack(
                            alignment: Alignment.topCenter,
                            children: [...previousChildren, ?currentChild],
                          );
                        },
                        child: _showSignUp
                            ? SignUpCard(onLoginTap: _toggleAuthMode)
                            : LogInCard(onSignUpTap: _toggleAuthMode),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          // Background decorative elements
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.primary.withAlpha(13),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            right: screenWidth * 0.4,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.tertiary.withAlpha(13),
              ),
            ),
          ),
          // Main content
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        colorScheme.primary.withAlpha(13),
                        colorScheme.primaryContainer.withAlpha(25),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo and branding
                        Row(
                          children: [
                            Icon(
                              Icons.route_rounded,
                              size: 48,
                              color: colorScheme.primary,
                            ),
                            SizedBox(width: 12),
                            RichText(
                              text: TextSpan(
                                text: 'Roadmap',
                                style: textTheme.displayMedium?.copyWith(
                                  fontWeight: FontWeight.w900,
                                ),
                                children: [
                                  TextSpan(
                                    text: '.ai',
                                    style: GoogleFonts.inter(
                                      color: colorScheme.primary,
                                      fontWeight: FontWeight.w900,
                                      fontSize:
                                          textTheme.displaySmall!.fontSize,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: screenHeight * 0.05),

                        // Animated text with visual enhancement
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: theme.cardColor,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(13),
                                blurRadius: 20,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.auto_awesome,
                                    color: colorScheme.primary,
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    'Why Roadmap.ai?',
                                    style: textTheme.titleMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              SizedBox(
                                height: screenHeight * 0.1,
                                child: AnimatedTextKit(
                                  pause: Duration(seconds: 2),
                                  repeatForever: true,
                                  animatedTexts: tagLines
                                      .map(
                                        (text) => TypewriterAnimatedText(
                                          text,
                                          speed: Duration(milliseconds: 40),
                                          textStyle: textTheme.titleLarge!
                                              .copyWith(
                                                fontWeight: FontWeight.w500,
                                              ),
                                          cursor: '|',
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.05),

                        // Feature highlights
                        Row(
                          children: [
                            FeatureItem(
                              icon: Icons.route,
                              title: 'Smart Roadmaps',
                              description:
                                  'AI-generated personalized learning paths',
                              color: colorScheme.primary,
                            ),
                            SizedBox(width: 24),
                            FeatureItem(
                              icon: Icons.group,
                              title: 'Community Support',
                              description:
                                  'Learn and grow with roadmaps made by the community',
                              color: colorScheme.tertiary,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              _showSignUp
                  ? SignUpCard(onLoginTap: _toggleAuthMode)
                  : LogInCard(onSignUpTap: _toggleAuthMode),
            ],
          ),
        ],
      ),
    );
  }
}
