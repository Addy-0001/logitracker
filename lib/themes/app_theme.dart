import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  const double mediumFontSize = 30;
  const double largeFontSize = 40;
  const double smallFontSize = 20;

  const FontWeight bold = FontWeight.bold;
  const FontWeight normal = FontWeight.w400;
  const FontWeight light = FontWeight.w100;

  const Color primaryColor = Color(0XFF8b1e1e);

  return ThemeData(
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      
      backgroundColor: primaryColor,
      elevation: 10,
      titleTextStyle: TextStyle(fontSize: largeFontSize, fontWeight: bold),
    ),

    // Color Theme
    colorScheme: ColorScheme.fromSeed(
      primary: primaryColor,
      seedColor: Color(0xFF8b1e1e),
      brightness: Brightness.light,
    ),

    // Text Theme
    textTheme: TextTheme(
      // Large Text Font Theme
      displayLarge: const TextStyle(
        fontSize: largeFontSize,
        fontWeight: bold,
        fontFamily: "IBM Plex Sans Bold",
      ),
      titleLarge: const TextStyle(
        fontSize: 40,
        fontWeight: bold,
        fontFamily: "IBM Plex Sans Bold",
      ),
      labelLarge: const TextStyle(
        fontSize: 40,
        fontWeight: bold,
        fontFamily: "IBM Plex Sans Bold",
      ),
      bodyLarge: const TextStyle(
        fontSize: 40,
        fontWeight: bold,
        fontFamily: "IBM Plex Sans Bold",
      ),
      headlineLarge: const TextStyle(
        fontSize: 40,
        fontWeight: bold,
        fontFamily: "IBM Plex Sans Bold",
      ),

      // Medium Text Font Theme
      bodyMedium: const TextStyle(
        fontSize: mediumFontSize,
        fontWeight: normal,
        fontFamily: "IBM Plex Sans Bold",
      ),
      labelMedium: const TextStyle(
        fontSize: mediumFontSize,
        fontWeight: normal,
        fontFamily: "IBM Plex Sans Regular",
      ),
      titleMedium: const TextStyle(
        fontSize: mediumFontSize,
        fontWeight: normal,
        fontFamily: "IBM Plex Sans Regular",
      ),
      displayMedium: const TextStyle(
        fontSize: mediumFontSize,
        fontWeight: normal,
        fontFamily: "IBM Plex Sans Regular",
      ),
      headlineMedium: const TextStyle(
        fontSize: mediumFontSize,
        fontWeight: normal,
        fontFamily: "IBM Plex Sans Regular",
      ),

      bodySmall: const TextStyle(
        fontSize: smallFontSize,
        fontWeight: light,
        fontFamily: "IBM Plex Sans Regular",
      ),
      labelSmall: const TextStyle(
        fontSize: smallFontSize,
        fontWeight: light,
        fontFamily: "IBM Plex Sans Regular",
      ),
      titleSmall: const TextStyle(
        fontSize: smallFontSize,
        fontWeight: light,
        fontFamily: "IBM Plex Sans Regular",
      ),
      displaySmall: const TextStyle(
        fontSize: smallFontSize,
        fontWeight: light,
        fontFamily: "IBM Plex Sans Regular",
      ),
      headlineSmall: const TextStyle(
        fontSize: smallFontSize,
        fontWeight: light,
        fontFamily: "IBM Plex Sans Regular",
      ),
    ),
  );
}
