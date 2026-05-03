// lib/constants/app_theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  // --- Light ---
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    primaryColor: const Color(0xFF1B4332),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF1B4332),
      secondary: Color(0xFF2D6A4F),
      surface: Color(0xFFF2FAF4),
      onPrimary: Color(0xFFB5E48C),   // text on CTA button
      onSurface: Color(0xFF111111),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFFFFFFF),
      hintStyle: const TextStyle(color: Color(0xFF999999)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF2D6A4F), width: 1.5),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1B4332),
        foregroundColor: const Color(0xFFB5E48C),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(color: Color(0xFF111111), fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(color: Color(0xFF444444)),
      bodySmall: TextStyle(color: Color(0xFF999999)),
    ),
  );

  // --- Dark ---
  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF141414),
    primaryColor: const Color(0xFF52C97A),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF52C97A),
      secondary: Color(0xFF00897B),
      surface: Color(0xFF252525),
      onPrimary: Color(0xFF0D2B18),   // text on CTA button
      onSurface: Color(0xFFFFFFFF),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF252525),
      hintStyle: const TextStyle(color: Color(0xFF666666)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.12)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.12)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF52C97A), width: 1.5),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF52C97A),
        foregroundColor: const Color(0xFF0D2B18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(color: Color(0xFFA0A0A0)),
      bodySmall: TextStyle(color: Color(0xFF666666)),
    ),
  );
}