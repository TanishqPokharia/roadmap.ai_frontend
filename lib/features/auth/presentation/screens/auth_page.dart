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
        body: SafeArea(
          child: Stack(
            children: [
              Animate(
                effects: [FadeEffect(delay: Durations.medium2)],
                child: Positioned(
                  top: -100,
                  left: -100,
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorScheme.secondary.withAlpha(50),
                    ),
                  ),
                ),
              ),
              // Animate(
              //   effects: [FadeEffect(delay: Durations.long2)],
              //   child: Positioned(
              //     bottom: 50,
              //     left: -350,
              //     child: Container(
              //       width: 400,
              //       height: 400,
              //       decoration: BoxDecoration(
              //         shape: BoxShape.circle,
              //         color: colorScheme.secondary.withAlpha(50),
              //       ),
              //     ),
              //   ),
              // ),
              Animate(
                effects: [FadeEffect(delay: Durations.medium4)],
                child: Positioned(
                  top: 200,
                  right: -350,
                  child: Container(
                    width: 400,
                    height: 400,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorScheme.secondary.withAlpha(50),
                    ),
                  ),
                ),
              ),

              Positioned(
                top: screenHeight / 4,
                right: screenWidth / 2.8,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(60),
                      child: Image.asset('assets/icon/icon.png', height: 100),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(60),
                      child: Container(
                        height: 100,
                        width: 100,
                        color: Colors.black.withAlpha(160),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            child: RichText(
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
                      if (!_showSignUp) SizedBox(height: 100),
                      _showSignUp
                          ? SignUpCard(onLoginTap: _toggleAuthMode)
                          : LogInCard(onSignUpTap: _toggleAuthMode),
                    ],
                  ),
                ),
              ),
            ],
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
              Expanded(
                child: _showSignUp
                    ? SignUpCard(onLoginTap: _toggleAuthMode)
                    : LogInCard(onSignUpTap: _toggleAuthMode),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
