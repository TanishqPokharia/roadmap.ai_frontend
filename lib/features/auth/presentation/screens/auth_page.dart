import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/features/auth/presentation/widgets/feature_item.dart';
import 'package:roadmap_ai/features/auth/presentation/widgets/log_in_card.dart';
import 'package:roadmap_ai/features/auth/presentation/widgets/sign_up_card.dart';
import 'package:typewritertext/typewritertext.dart';

class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({super.key});

  @override
  ConsumerState<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage> {
  bool _showSignUp = false;

  final valueController = TypeWriterController.fromValue(
    TypeWriterValue([
      'Get personalized AI powered roadmaps for every skill or goal within seconds',
      'Personalized learning and global community support - All at one place',
      'Join a community of learners and achieve your goals faster',
    ]),
    duration: const Duration(milliseconds: 50),
    repeat: true,
  );

  void _toggleAuthMode() {
    setState(() {
      _showSignUp = !_showSignUp;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;

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
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w900,
                                  fontSize: textTheme.displayMedium!.fontSize,
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
                            color: Colors.white,
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
                                  animatedTexts:
                                      [
                                            'Get personalized AI powered roadmaps for every skill or goal within seconds.',
                                            'Personalized learning and global community support - All at one place.',
                                            'Join a community of learners and achieve your goals faster.',
                                          ]
                                          .map(
                                            (text) => TypewriterAnimatedText(
                                              text,
                                              speed: Duration(milliseconds: 40),
                                              textStyle: textTheme.titleLarge!
                                                  .copyWith(
                                                    color: Colors.blueGrey,
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
