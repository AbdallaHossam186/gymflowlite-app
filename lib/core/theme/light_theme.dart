import 'package:flutter/material.dart';
import 'colors.dart';
import 'text_styles.dart';
import 'components/buttons.dart';
import 'components/cards.dart';
import 'components/inputs.dart';
import 'components/chips.dart';
import 'components/bottom_nav.dart';

class LightTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,

      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryAccent,
        primary: AppColors.primaryAccent,
        secondary: AppColors.secondaryAccent,
        background: AppColors.background,
        surface: AppColors.surface,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onBackground: AppColors.textPrimary,
        onSurface: AppColors.textPrimary,
        brightness: Brightness.light,
      ),

      textTheme: TextTheme(
        displayLarge: AppTextStyles.displayLarge,
        displayMedium: AppTextStyles.displayMedium,
        headlineLarge: AppTextStyles.headlineLarge,
        headlineMedium: AppTextStyles.headlineMedium,
        titleLarge: AppTextStyles.titleLarge,
        bodyLarge: AppTextStyles.bodyLarge,
        bodyMedium: AppTextStyles.bodyMedium,
      ),

      elevatedButtonTheme: AppButtonThemes.elevatedButtonTheme,
      cardTheme: AppCardTheme.cardTheme,
      inputDecorationTheme: AppInputTheme.inputDecorationTheme,
      chipTheme: AppChipTheme.chipTheme,
      bottomNavigationBarTheme: AppBottomNavTheme.bottomNavTheme,
    );
  }
}
