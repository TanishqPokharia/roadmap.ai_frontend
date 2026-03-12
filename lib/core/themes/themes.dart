import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final _globalTextTheme = GoogleFonts.teachersTextTheme;

final lightColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.deepPurple.shade900,
  brightness: Brightness.light,
);

final darkColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.deepPurple.shade900,
  brightness: Brightness.dark,
);

ThemeData lightTheme = ThemeData.light().copyWith(
  splashFactory: NoSplash.splashFactory,
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      foregroundColor: lightColorScheme.primaryContainer,
      textStyle: GoogleFonts.teachers(fontWeight: FontWeight.bold),
    ),
  ),
  textTheme: _globalTextTheme(ThemeData.light().textTheme),
  cardColor: lightColorScheme.onPrimary,
  colorScheme: lightColorScheme,
);

ThemeData darkTheme = ThemeData.dark().copyWith(
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
      foregroundColor: darkColorScheme.primaryContainer,
      textStyle: GoogleFonts.teachers(fontWeight: FontWeight.bold),
    ),
  ),
  textTheme: _globalTextTheme(ThemeData.dark().textTheme),
  colorScheme: darkColorScheme,
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
