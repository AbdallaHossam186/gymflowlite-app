import 'package:flutter/material.dart';
import '../colors.dart';

class AppCardTheme {
  static final cardTheme = CardThemeData(
    color: AppColors.surface,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
  );
}
