import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/features/auth/presentation/providers/login/login_notifier.dart';
import 'package:roadmap_ai/core/themes/colors.dart';
import 'package:validatorless/validatorless.dart';

class LogInCard extends ConsumerStatefulWidget {
  final VoidCallback? onSignUpTap;

  const LogInCard({super.key, this.onSignUpTap});

  @override
  ConsumerState<LogInCard> createState() => _LogInCardState();
}

class _LogInCardState extends ConsumerState<LogInCard> {
  bool _showPassword = false;
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

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
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                      ),
                      child: TextFormField(
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
                        validator: (value) => Validatorless.multiple([
                          Validatorless.required('Email is required'),
                          Validatorless.email('Enter a valid email'),
                        ])(value),
                        onSaved: (newValue) {
                          _email = newValue ?? '';
                        },
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.02),

                    // Password field
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                      ),
                      child: TextFormField(
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
                        validator: (value) => Validatorless.multiple([
                          Validatorless.required('Password is required'),
                          Validatorless.min(
                            6,
                            'Password must be at least 6 characters',
                          ),
                        ])(value),
                        onSaved: (newValue) {
                          _password = newValue ?? '';
                        },
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.03),

                    // Login button
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return SizedBox(
                          width: constraints.maxWidth / 3,
                          height: screenHeight * 0.05,
                          child: Consumer(
                            builder: (context, ref, _) {
                              return ref
                                  .watch(loginNotifierProvider)
                                  .maybeWhen(
                                    orElse: () {
                                      return FilledButton(
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            _formKey.currentState!.save();
                                            ref
                                                .read(
                                                  loginNotifierProvider
                                                      .notifier,
                                                )
                                                .login(_email, _password);
                                          }
                                        },
                                        child: Text(
                                          'Login',
                                          style: textTheme.titleMedium!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                        ),
                                      );
                                    },

                                    loading: () {
                                      return Container(
                                        width: double.infinity,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          color: colorScheme.primary,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
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
      ),
    );
  }
}
