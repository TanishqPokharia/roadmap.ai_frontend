import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:roadmap_ai/core/common/toast/error.dart';
import 'package:roadmap_ai/core/common/toast/success.dart';
import 'package:roadmap_ai/core/common/widgets/clickable_text.dart';
import 'package:roadmap_ai/core/constants/constants.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/features/auth/presentation/providers/login/login_notifier.dart';
import 'package:validatorless/validatorless.dart';

class LogInCard extends ConsumerStatefulWidget {
  final VoidCallback onSignUpTap;

  const LogInCard({super.key, required this.onSignUpTap});

  @override
  ConsumerState<LogInCard> createState() => _LogInCardState();
}

class _LogInCardState extends ConsumerState<LogInCard> {
  bool _showPassword = false;
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  void googleSignIn() async {
    final googleSignIn = GoogleSignIn.instance;
    if (!googleSignIn.supportsAuthenticate()) {
      showErrorToast(
        context: context,
        error: "Google sign in not supported on this device",
      );
      return;
    }
    final user = await googleSignIn.authenticate();
    final googleIdToken = user.authentication.idToken;
    if (googleIdToken == null) {
      if (mounted) {
        showErrorToast(context: context, error: "Error signing with Google");
      }
      return;
    }
    ref
        .read(loginProvider.notifier)
        .loginWithGoogle(googleIdToken: googleIdToken);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.screenHeight;
    final colorScheme = context.colorScheme;
    final screenWidth = context.screenWidth;
    final textTheme = context.textTheme;
    final theme = context.theme;
    final isDarkMode = context.theme.brightness == Brightness.dark;
    final isLoading = ref.watch(loginProvider).isLoading;

    if (AppConstants.isAndroid) {
      return Form(
        key: _formKey,
        child: Card(
          color: colorScheme.surfaceContainer,
          elevation: 50,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Welcome ',
                                style: textTheme.headlineMedium,
                              ),
                              TextSpan(
                                text: 'Back',
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
                              onComplete: (controller) =>
                                  controller.repeat(reverse: false),
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
                                  color: colorScheme.primary,
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

                        SizedBox(height: 16),

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
                      ],
                    ),
                    SizedBox(height: 36),
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
                            text: "Don't have an account?  ",
                            style: textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = widget.onSignUpTap,
                                style: textTheme.bodyLarge?.copyWith(
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                                text: 'Sign Up',
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
                    SizedBox(height: 36),
                    // Login button
                    SizedBox(
                      width: double.infinity,
                      child: Consumer(
                        builder: (context, ref, _) {
                          return GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                ref
                                    .read(loginProvider.notifier)
                                    .login(email: _email, password: _password);
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                color: colorScheme.primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  'Login',
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
                    SizedBox(height: 10),
                    Row(
                      spacing: 10,
                      children: <Widget>[
                        Expanded(child: Divider(color: colorScheme.primary)),
                        Text(
                          'or',
                          style: TextStyle(color: colorScheme.primary),
                        ),
                        Expanded(child: Divider(color: colorScheme.primary)),
                      ],
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: googleSignIn,
                      child: SvgPicture.asset(
                        isDarkMode
                            ? "assets/web_dark_sq_ctn.svg"
                            : "assets/web_light_sq_ctn.svg",
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
          child: Center(
            child: Card(
              elevation: 40,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              child: Container(
                padding: EdgeInsets.all(screenWidth * 0.04),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [theme.cardColor, theme.cardColor.withAlpha(230)],
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
                          errorStyle: textTheme.titleSmall?.copyWith(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                          contentPadding: EdgeInsets.all(40),
                          filled: true,
                          hoverColor: Colors.transparent,
                          fillColor: colorScheme.primary.withValues(alpha: 240),
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
                          contentPadding: EdgeInsets.symmetric(vertical: 40),
                          hoverColor: Colors.transparent,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: colorScheme.primary,
                              width: 1,
                            ),
                          ),
                          filled: true,
                          fillColor: colorScheme.primary.withValues(alpha: 240),
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

                    SizedBox(height: screenHeight * 0.03),

                    // Login button
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return SizedBox(
                          width: constraints.maxWidth / 3,
                          height: screenHeight * 0.04,
                          child: Consumer(
                            builder: (context, ref, _) {
                              return switch (ref.watch(loginProvider)) {
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
                                (_) => FilledButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      ref
                                          .read(loginProvider.notifier)
                                          .login(
                                            email: _email,
                                            password: _password,
                                          );
                                    }
                                  },
                                  child: Text(
                                    'Login',
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

                    // Sign up option
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 10,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ClickableText(
                          text: 'Sign Up',
                          style: textTheme.titleMedium?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                          onClick: widget.onSignUpTap,
                        ),
                      ],
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
