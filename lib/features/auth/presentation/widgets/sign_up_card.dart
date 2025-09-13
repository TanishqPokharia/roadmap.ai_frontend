import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/core/themes/colors.dart';
import 'package:roadmap_ai/features/auth/presentation/providers/signup/signup_notifier.dart';
import 'package:validatorless/validatorless.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SignUpCard extends ConsumerStatefulWidget {
  final VoidCallback onLoginTap;

  const SignUpCard({super.key, required this.onLoginTap});

  @override
  ConsumerState<SignUpCard> createState() => _SignUpCardState();
}

class _SignUpCardState extends ConsumerState<SignUpCard> {
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  String _email = '';
  String _username = '';
  String _password = '';
  String _confirmPassword = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.screenHeight;
    final colorScheme = context.colorScheme;
    final screenWidth = context.screenWidth;
    final textTheme = context.textTheme;

    return Form(
      key: _formKey,
      child: Container(
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
                    TextFormField(
                      onSaved: (newValue) {
                        _email = newValue ?? '';
                      },
                      validator: Validatorless.multiple([
                        Validatorless.required('Email is required'),
                        Validatorless.email('Enter a valid email'),
                      ]),
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

                    // Username field
                    TextFormField(
                      onSaved: (newValue) {
                        _username = newValue ?? '';
                      },
                      validator: Validatorless.required('Username is required'),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: buttonColor,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        hintText: 'Username',
                        hintStyle: textTheme.bodyLarge!.copyWith(
                          color: Colors.blueGrey,
                        ),
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // Password field
                    TextFormField(
                      onChanged: (value) {
                        _password = value;
                      },
                      onSaved: (newValue) {
                        _password = newValue ?? '';
                      },
                      validator: Validatorless.multiple([
                        Validatorless.required('Password is required'),
                        Validatorless.min(
                          8,
                          'Password must be at least 8 characters',
                        ),
                      ]),
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
                    TextFormField(
                      onChanged: (value) {
                        _confirmPassword = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Confirm Password is required';
                        }
                        if (_confirmPassword != _password) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
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
                          width: constraints.maxWidth / 3,
                          height: screenHeight * 0.05,
                          child: Consumer(
                            builder: (context, ref, _) {
                              return switch (ref.watch(
                                signupNotifierProvider,
                              )) {
                                AsyncLoading() => Container(
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
                                ),
                                _ => FilledButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      ref
                                          .read(signupNotifierProvider.notifier)
                                          .signUp(
                                            email: _email,
                                            username: _username,
                                            password: _password,
                                          );
                                    }
                                  },
                                  child: Text(
                                    'Sign Up',
                                    style: textTheme.titleMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              };
                            },
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
      ),
    );
  }
}
