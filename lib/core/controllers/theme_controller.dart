// lib/core/controllers/theme_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final _storage = GetStorage();

  static const _keyIsManual = 'isManualTheme';
  static const _keyIsDark   = 'isDarkMode';

  ThemeMode get themeMode {
    final isManual = _storage.read<bool>(_keyIsManual) ?? false;
    if (!isManual) return ThemeMode.system;
    final isDark = _storage.read<bool>(_keyIsDark) ?? false;
    return isDark ? ThemeMode.dark : ThemeMode.light;
  }

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) return Get.isPlatformDarkMode;
    return themeMode == ThemeMode.dark;
  }

  bool get isManualOverride => _storage.read<bool>(_keyIsManual) ?? false;

  void toggleTheme() {
    setTheme(isDarkMode ? ThemeMode.light : ThemeMode.dark);
  }

  void setTheme(ThemeMode mode) {
    if (mode == ThemeMode.system) {
      resetToSystem();
      return;
    }
    _storage.write(_keyIsManual, true);
    _storage.write(_keyIsDark, mode == ThemeMode.dark);
    Get.changeThemeMode(mode);
    update();
  }

  void resetToSystem() {
    _storage.remove(_keyIsManual);
    _storage.remove(_keyIsDark);
    Get.changeThemeMode(ThemeMode.system);
    update();
  }
}