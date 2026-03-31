import 'package:flutter/material.dart';
import '../colors.dart';
import '../text_styles.dart';

class AppChipTheme {
  static final chipTheme = ChipThemeData(
    backgroundColor: Colors.white,
    selectedColor: AppColors.primaryAccent,
    secondarySelectedColor: AppColors.primaryAccent,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    labelStyle: AppTextStyles.bodyMedium.copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
    secondaryLabelStyle: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
    shape: const StadiumBorder(),
    side: BorderSide.none,
  );
}
