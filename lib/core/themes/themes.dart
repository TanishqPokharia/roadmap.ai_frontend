import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  const AppTheme._();
  static final _globalTextTheme = GoogleFonts.teachersTextTheme;

  static final _lightColorScheme = ColorScheme.fromSeed(
    seedColor: Colors.deepPurple.shade900,
    brightness: Brightness.light,
  );

  static final _darkColorScheme = ColorScheme.fromSeed(
    seedColor: Colors.deepPurple.shade900,
    brightness: Brightness.dark,
  );

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    splashFactory: NoSplash.splashFactory,
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        foregroundColor: _lightColorScheme.primaryContainer,
        textStyle: GoogleFonts.teachers(fontWeight: FontWeight.bold),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        foregroundColor: _lightColorScheme.primary,
        textStyle: GoogleFonts.teachers(fontWeight: FontWeight.bold),
      ),
    ),
    textTheme: _globalTextTheme(ThemeData.light().textTheme),
    cardColor: _lightColorScheme.onPrimary,
    colorScheme: _lightColorScheme,
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[900],
      iconTheme: IconThemeData(color: Colors.white),
    ),
    // chipTheme: ChipThemeData.fromDefault(
    //   secondaryColor: Colors.deepPurple.shade900,
    //   brightness: Brightness.dark,
    // ),
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: Colors.white70,
      hintStyle: GoogleFonts.inter(color: Colors.white70),
    ),
    cardColor: Color(0xFF28282B),
    splashFactory: NoSplash.splashFactory,
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        foregroundColor: _darkColorScheme.primaryContainer,
        textStyle: GoogleFonts.teachers(fontWeight: FontWeight.bold),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        foregroundColor: _lightColorScheme.primary,
        textStyle: GoogleFonts.teachers(fontWeight: FontWeight.bold),
      ),
    ),
    textTheme: _globalTextTheme(ThemeData.dark().textTheme),
    colorScheme: _darkColorScheme,
    checkboxTheme: CheckboxThemeData(
      // overlayColor: WidgetStatePropertyAll(Colors.purpleAccent.withAlpha(50)),
      checkColor: WidgetStatePropertyAll(Colors.white),
      side: BorderSide(color: Colors.white),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: Colors.grey[900],
      textStyle: GoogleFonts.inter(
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );
}
