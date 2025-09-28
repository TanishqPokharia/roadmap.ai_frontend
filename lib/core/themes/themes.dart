import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final lightColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.blueGrey,
).copyWith(primaryContainer: Colors.blueGrey.shade700);

final darkColorScheme = ColorScheme.fromSeed(seedColor: Colors.purpleAccent)
    .copyWith(
      brightness: Brightness.dark,
      primary: Colors.purpleAccent.withAlpha(150),
      onPrimary: Colors.white,
      secondary: Colors.purpleAccent,
      onSecondary: Colors.white,
      surface: Colors.grey[850],
      onSurface: Colors.white,
    );

ThemeData lightTheme = ThemeData.light().copyWith(
  splashFactory: NoSplash.splashFactory,
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    ),
  ),
  textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme),
  cardColor: lightColorScheme.onPrimary,
  colorScheme: lightColorScheme,
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[900],
    iconTheme: IconThemeData(color: Colors.white),
  ),
  chipTheme: ChipThemeData.fromDefaults(
    secondaryColor: Colors.purpleAccent,
    brightness: Brightness.dark,
    labelStyle: GoogleFonts.inter(
      color: Colors.white,

      fontWeight: FontWeight.w500,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    prefixIconColor: Colors.white70,
    hintStyle: GoogleFonts.inter(color: Colors.white70),
  ),
  cardColor: Colors.grey[900],
  splashFactory: NoSplash.splashFactory,
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      backgroundColor: Colors.purpleAccent.shade700,
      foregroundColor: Colors.white,
    ),
  ),
  textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
  colorScheme: darkColorScheme,
  checkboxTheme: CheckboxThemeData(
    overlayColor: WidgetStatePropertyAll(Colors.purpleAccent.withAlpha(50)),
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
