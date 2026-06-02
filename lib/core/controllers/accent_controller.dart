// lib/core/controllers/accent_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sentro/core/constants/colors.dart';
import 'package:sentro/core/controllers/theme_controller.dart';

class AccentController extends GetxController {
  static AccentController get to => Get.find();

  final _storage = GetStorage();
  static const _key = 'accentColor';
  static const Color _defaultAccent = sNavContainer;

  bool get isDefault => accent.value.value == _defaultAccent.value;

  // All available accent options
  static const List<Color> options = [
    sNavContainer, // default green (sNavContainer)
    sCancel, // red (sCancel)
    sBlue, // blue (sBlue)
    sLilac, // lilac (sLilac)
    sAccentGreen,// accent green (sAccentGreen)
    sAccentPink,// pink (sAccentPink)
    sAccentPurple,// purple (sAccentPurple)
    sAccentAmber, // amber (sAccentAmber)
  ];

  late final Rx<Color> accent;

  @override
  void onInit() {
    super.onInit();
    final saved = _storage.read<int>(_key);
    accent = Rx<Color>(
      saved != null ? Color(saved) : options.first,
    );
  }

  void setAccent(Color color) {
    accent.value = color;
    _storage.write(_key, color.value);
    _rebuildTheme();
  }

  void _rebuildTheme() {
    // Force GetX to re-apply theme so colorScheme.primary updates
    final ctrl = Get.find<ThemeController>();
    Get.changeTheme(ctrl.isDarkMode
        ? _darkWithAccent(accent.value)
        : _lightWithAccent(accent.value));
  }

  // Light theme with dynamic accent
  static ThemeData lightWithAccent(Color accent) => _lightWithAccent(accent);
  static ThemeData darkWithAccent(Color accent)  => _darkWithAccent(accent);

  static ThemeData _lightWithAccent(Color a) => ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    primaryColor: a,
    colorScheme: ColorScheme.light(
      primary: a,
      secondary: a.withOpacity(0.7),
      surface: const Color(0xFFF2FAF4),
      onPrimary: const Color(0xFFB5E48C),
      onSurface: const Color(0xFF111111),
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
        borderSide: BorderSide(color: a, width: 1.5),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: a,
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

  static ThemeData _darkWithAccent(Color a) => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF141414),
    primaryColor: a,
    colorScheme: ColorScheme.dark(
      primary: a,
      secondary: const Color(0xFF00897B),
      surface: const Color(0xFF252525),
      onPrimary: const Color(0xFF0D2B18),
      onSurface: const Color(0xFFFFFFFF),
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
        borderSide: BorderSide(color: a, width: 1.5),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: a,
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