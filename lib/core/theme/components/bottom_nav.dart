import 'package:flutter/material.dart';
import '../colors.dart';

class AppBottomNavTheme {
  static const bottomNavTheme = BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: AppColors.primaryAccent,
    unselectedItemColor: AppColors.textSecondary,
    type: BottomNavigationBarType.fixed,
    elevation: 8,
  );
}
