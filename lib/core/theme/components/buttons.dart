import 'package:flutter/material.dart';
import '../colors.dart';
import '../text_styles.dart';

class AppButtonThemes {
  static final elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryAccent,
      foregroundColor: Colors.white,
      minimumSize: const Size(double.infinity, 56),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      textStyle: AppTextStyles.titleLarge.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      elevation: 0,
    ),
  );
}
