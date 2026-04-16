import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymflow_lite/modules/auth/controllers/auth_controller.dart';
import 'package:gymflow_lite/modules/auth/views/login_view.dart';
import 'package:gymflow_lite/modules/home/views/home_view.dart';
import 'package:gymflow_lite/modules/splash_screen/views/splash_page.dart';

class AuthWrapper extends GetView<AuthController> {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Checking auth state
      if (controller.isCheckingAuth.value) {
        return SplashPage();
      }

      // ❌ Not logged in
      if (controller.firebaseUser.value == null) {
        return LoginView();
      }

      // ✅ Fully ready
      return HomeView();
    });
  }
}
