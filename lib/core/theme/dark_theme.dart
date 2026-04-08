import 'package:flutter/material.dart';
import 'colors.dart';
import 'light_theme.dart';

class DarkTheme {
  static ThemeData get theme {
    return LightTheme.theme.copyWith(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryAccent,
        primary: AppColors.primaryAccent,
        secondary: AppColors.secondaryAccent,
        surface: const Color(0xFF1E1E1E),
        onSurface: Colors.white,
        brightness: Brightness.dark,
      ),
    );
  }
}
