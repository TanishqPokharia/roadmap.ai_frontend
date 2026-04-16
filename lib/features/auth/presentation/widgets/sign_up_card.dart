import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:roadmap_ai/core/common/widgets/clickable_text.dart';
import 'package:roadmap_ai/core/constants/constants.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/features/auth/presentation/providers/signup/signup_notifier.dart';
import 'package:validatorless/validatorless.dart';

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
    final theme = context.theme;
    final isLoading = ref.watch(signupProvider).isLoading;

    if (AppConstants.isAndroid) {
      return Form(
        key: _formKey,
        child: Card(
          color: colorScheme.surfaceContainer,
          elevation: 50,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  spacing: 5,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Create ',
                                style: textTheme.headlineMedium,
                              ),
                              TextSpan(
                                text: 'Account',
                                style: textTheme.headlineMedium?.copyWith(
                                  color: context.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Ready to ', style: textTheme.headlineSmall),
                            Animate(
                              onComplete: (controller) {
                                controller.repeat(reverse: false);
                              },
                              effects: [
                                ShimmerEffect(
                                  duration: Duration(seconds: 5),
                                  colors: [
                                    colorScheme.primary,
                                    colorScheme.surface,
                                    colorScheme.primary,
                                  ],
                                ),
                              ],
                              child: Text(
                                'Level Up?',
                                style: textTheme.headlineSmall?.copyWith(
                                  color: context.colorScheme.secondary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    Column(
                      children: [
                        TextFormField(
                          style: textTheme.bodyLarge,
                          decoration: InputDecoration(
                            errorStyle: textTheme.bodySmall?.copyWith(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                            contentPadding: EdgeInsets.all(10),
                            hoverColor: Colors.transparent,
                            fillColor: colorScheme.primary.withValues(
                              alpha: 240,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: colorScheme.primary,

                                width: 1,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            hintText: 'Email',
                            hintStyle: textTheme.bodyLarge!.copyWith(
                              color: Colors.grey,
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

                        SizedBox(height: 12),

                        TextFormField(
                          style: textTheme.bodyLarge,
                          decoration: InputDecoration(
                            errorStyle: textTheme.bodySmall?.copyWith(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                            contentPadding: EdgeInsets.all(10),
                            hoverColor: Colors.transparent,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: colorScheme.primary,
                                width: 1,
                              ),
                            ),
                            fillColor: colorScheme.primary.withValues(
                              alpha: 240,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            hintText: 'Username',
                            hintStyle: textTheme.bodyLarge!.copyWith(
                              color: Colors.grey,
                            ),
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                          validator: Validatorless.required(
                            'Username is required',
                          ),
                          onSaved: (newValue) {
                            _username = newValue ?? '';
                          },
                        ),
                        SizedBox(height: 12),

                        // Password field
                        TextFormField(
                          style: textTheme.bodyLarge,
                          decoration: InputDecoration(
                            errorStyle: textTheme.bodySmall?.copyWith(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                            contentPadding: EdgeInsets.all(10),
                            hoverColor: Colors.transparent,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: colorScheme.primary,
                                width: 1,
                              ),
                            ),
                            fillColor: colorScheme.primary.withValues(
                              alpha: 240,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            hintText: 'Password',
                            hintStyle: textTheme.bodyLarge!.copyWith(
                              color: Colors.grey,
                            ),
                            prefixIcon: Icon(Icons.lock_outline),
                            suffixIcon: _showPassword
                                ? IconButton(
                                    icon: Icon(
                                      Icons.visibility_outlined,
                                      color: colorScheme.secondary,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _showPassword = false;
                                      });
                                    },
                                  )
                                : IconButton(
                                    icon: Icon(
                                      Icons.visibility_off_outlined,
                                      color: colorScheme.secondary,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _showPassword = true;
                                      });
                                    },
                                  ),
                          ),
                          obscureText: !_showPassword,
                          onChanged: (value) {
                            _password = value;
                          },
                          validator: (value) => Validatorless.multiple([
                            Validatorless.required('Password is required'),
                            Validatorless.min(
                              8,
                              'Password must be at least 8 characters',
                            ),
                          ])(value),
                          onSaved: (newValue) {
                            _password = newValue ?? '';
                          },
                        ),
                        SizedBox(height: 12),
                        // Confirm Password field
                        TextFormField(
                          style: textTheme.bodyLarge,
                          decoration: InputDecoration(
                            errorStyle: textTheme.bodySmall?.copyWith(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                            contentPadding: EdgeInsets.all(10),
                            hoverColor: Colors.transparent,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: colorScheme.primary,
                                width: 1,
                              ),
                            ),
                            fillColor: colorScheme.primary.withValues(
                              alpha: 240,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            hintText: 'Confirm Password',
                            hintStyle: textTheme.bodyLarge!.copyWith(
                              color: Colors.grey,
                            ),
                            prefixIcon: Icon(Icons.lock_outline),
                            suffixIcon: _showConfirmPassword
                                ? IconButton(
                                    icon: Icon(
                                      Icons.visibility_outlined,
                                      color: colorScheme.secondary,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _showConfirmPassword = false;
                                      });
                                    },
                                  )
                                : IconButton(
                                    icon: Icon(
                                      Icons.visibility_off_outlined,
                                      color: colorScheme.secondary,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _showConfirmPassword = true;
                                      });
                                    },
                                  ),
                          ),
                          obscureText: !_showConfirmPassword,
                          onChanged: (value) {
                            _confirmPassword = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Confirm Password is required';
                            }
                            if (value != _password) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            _confirmPassword = newValue ?? '';
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Container(
                            height: 2,
                            color: colorScheme.primary,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: "Already have an account?  ",
                            style: textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = widget.onLoginTap,
                                style: textTheme.bodyLarge?.copyWith(
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                                text: 'Log In',
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 2,
                            color: colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Sign Up button
                    SizedBox(
                      width: double.infinity,
                      child: Consumer(
                        builder: (context, ref, _) {
                          return GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                ref
                                    .read(signupProvider.notifier)
                                    .signUp(
                                      email: _email,
                                      username: _username,
                                      password: _password,
                                    );
                              }
                            },
                            child: AnimatedContainer(
                              duration: Durations.short4,
                              curve: Curves.easeOut,
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                color: colorScheme.primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  'Sign Up',
                                  style: textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              if (isLoading)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorScheme.surface.withAlpha(150),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: colorScheme.primary,
                        size: 40,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    }

    return Form(
      key: _formKey,
      child: SizedBox(
        height: screenHeight,
        // decoration: BoxDecoration(color: colorScheme.surface),
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.02),
          child: Column(
            children: [
              Center(
                child: Card(
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          theme.cardColor,
                          theme.cardColor.withAlpha(230),
                        ],
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
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05,
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              errorStyle: textTheme.titleSmall?.copyWith(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                              contentPadding: EdgeInsets.all(20),
                              filled: true,
                              fillColor: theme.cardColor.withValues(alpha: 300),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: colorScheme.primary,
                                  width: 1,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              hintText: 'Email',
                              hintStyle: textTheme.bodyLarge!.copyWith(
                                color: Colors.grey,
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

                        // Username field
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05,
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              errorStyle: textTheme.titleSmall?.copyWith(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                              contentPadding: EdgeInsets.all(20),
                              filled: true,
                              fillColor: theme.cardColor.withValues(alpha: 300),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: colorScheme.primary,
                                  width: 1,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              hintText: 'Username',
                              hintStyle: textTheme.bodyLarge!.copyWith(
                                color: Colors.grey,
                              ),
                              prefixIcon: Icon(Icons.person_outline),
                            ),
                            validator: Validatorless.required(
                              'Username is required',
                            ),
                            onSaved: (newValue) {
                              _username = newValue ?? '';
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
                              errorStyle: textTheme.titleSmall?.copyWith(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 20,
                              ),
                              hoverColor: theme.hoverColor,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: colorScheme.primary,
                                  width: 1,
                                ),
                              ),
                              filled: true,
                              fillColor: theme.cardColor.withValues(alpha: 300),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              hintText: 'Password',
                              hintStyle: textTheme.bodyLarge!.copyWith(
                                color: Colors.grey,
                              ),
                              prefixIcon: Icon(Icons.lock_outline),
                              suffixIcon: _showPassword
                                  ? IconButton(
                                      icon: Icon(
                                        Icons.visibility_outlined,
                                        color: colorScheme.primary,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _showPassword = false;
                                        });
                                      },
                                    )
                                  : IconButton(
                                      icon: Icon(
                                        Icons.visibility_off_outlined,
                                        color: colorScheme.primary,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _showPassword = true;
                                        });
                                      },
                                    ),
                            ),
                            obscureText: !_showPassword,
                            onChanged: (value) {
                              _password = value;
                            },
                            validator: (value) => Validatorless.multiple([
                              Validatorless.required('Password is required'),
                              Validatorless.min(
                                8,
                                'Password must be at least 8 characters',
                              ),
                            ])(value),
                            onSaved: (newValue) {
                              _password = newValue ?? '';
                            },
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.02),

                        // Confirm Password field
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05,
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              errorStyle: textTheme.titleSmall?.copyWith(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 20,
                              ),
                              hoverColor: theme.hoverColor,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: colorScheme.primary,
                                  width: 1,
                                ),
                              ),
                              filled: true,
                              fillColor: theme.cardColor.withValues(alpha: 300),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              hintText: 'Confirm Password',
                              hintStyle: textTheme.bodyLarge!.copyWith(
                                color: Colors.grey,
                              ),
                              prefixIcon: Icon(Icons.lock_outline),
                              suffixIcon: _showConfirmPassword
                                  ? IconButton(
                                      icon: Icon(
                                        Icons.visibility_outlined,
                                        color: colorScheme.primary,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _showConfirmPassword = false;
                                        });
                                      },
                                    )
                                  : IconButton(
                                      icon: Icon(
                                        Icons.visibility_off_outlined,
                                        color: colorScheme.primary,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _showConfirmPassword = true;
                                        });
                                      },
                                    ),
                            ),
                            obscureText: !_showConfirmPassword,
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
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.03),

                        // Sign Up button
                        LayoutBuilder(
                          builder: (context, constraints) {
                            return SizedBox(
                              width: constraints.maxWidth / 3,
                              height: screenHeight * 0.04,
                              child: Consumer(
                                builder: (context, ref, _) {
                                  return switch (ref.watch(signupProvider)) {
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
                                              .read(signupProvider.notifier)
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

                        SizedBox(height: screenHeight * 0.08),

                        // Login option
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 10,
                          children: [
                            Text(
                              "Already have an account?",
                              style: textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ClickableText(
                              text: 'Log in',
                              style: textTheme.titleMedium?.copyWith(
                                color: colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                              onClick: widget.onLoginTap,
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.01),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
