import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/themes/colors.dart';

class SignUpCard extends StatefulWidget {
  final VoidCallback onLoginTap;

  const SignUpCard({super.key, required this.onLoginTap});

  @override
  State<SignUpCard> createState() => _SignUpCardState();
}

class _SignUpCardState extends State<SignUpCard> {
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.screenHeight;
    final colorScheme = context.colorScheme;
    final screenWidth = context.screenWidth;
    final textTheme = context.textTheme;

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
                      Icons.person_add_rounded,
                      color: colorScheme.primary,
                      size: 32,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    'Create Account',
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

                  SizedBox(height: screenHeight * 0.02),

                  // Confirm Password field
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: buttonColor,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: 'Confirm Password',
                      hintStyle: textTheme.bodyLarge!.copyWith(
                        color: Colors.blueGrey,
                      ),
                      prefixIcon: Icon(Icons.lock_outline),
                      suffixIcon: _showConfirmPassword
                          ? IconButton(
                              icon: Icon(Icons.visibility_outlined),
                              onPressed: () {
                                setState(() {
                                  _showConfirmPassword = false;
                                });
                              },
                            )
                          : IconButton(
                              icon: Icon(Icons.visibility_off_outlined),
                              onPressed: () {
                                setState(() {
                                  _showConfirmPassword = true;
                                });
                              },
                            ),
                    ),
                    obscureText: !_showConfirmPassword,
                  ),

                  SizedBox(height: screenHeight * 0.03),

                  // Sign Up button
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return SizedBox(
                        width: constraints.maxWidth / 2,
                        height: screenHeight * 0.05,
                        child: FilledButton(
                          onPressed: () {
                            // Sign up action
                          },
                          child: Text(
                            'Sign Up',
                            style: textTheme.titleMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  // Login option
                  Flexible(
                    child: RichText(
                      text: TextSpan(
                        text: "Already have an account? ",
                        style: textTheme.bodyMedium,
                        children: [
                          TextSpan(
                            text: 'Log in',
                            style: textTheme.bodyMedium!.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = widget.onLoginTap,
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
