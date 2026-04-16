import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymflow_lite/modules/auth/data/repositories/auth_repository.dart';
import 'package:gymflow_lite/routes/app_routes.dart';

class LoginController extends GetxController {
  final AuthRepository _repo;

  LoginController(this._repo);

  // ── Form state ──────────────────────────────────────────────────────────
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // ── Reactive state ──────────────────────────────────────────────────────
  final RxBool obscurePassword = true.obs;
  final RxBool isLoading = false.obs;
  final RxBool isGoogleLoading = false.obs;

  // ── Login with Email ────────────────────────────────────────────────────

  Future<void> login() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    try {
      isLoading.value = true;
      await _repo.login(emailController.text.trim(), passwordController.text);
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      _showError(_cleanErrorMessage(e));
    } finally {
      isLoading.value = false;
    }
  }

  // ── Login with Google ───────────────────────────────────────────────────

  Future<void> loginWithGoogle() async {
    try {
      isGoogleLoading.value = true;
      final result = await _repo.loginWithGoogle();

      if (result.isNewUser || !result.user.isProfileComplete) {
        // New user or existing user with incomplete profile → collect details.
        Get.offAllNamed(AppRoutes.compeleteYourProfile);
      } else {
        // Returning user with a complete profile → go straight to Home.
        Get.offAllNamed(AppRoutes.home);
      }
    } catch (e) {
      _showError(_cleanErrorMessage(e));
    } finally {
      isGoogleLoading.value = false;
    }
  }

  // ── Reset Password ─────────────────────────────────────────────────────

  Future<void> resetPassword(String email) async {
    try {
      await _repo.resetPassword(email);
      Get.snackbar(
        'Email Sent',
        'Check your inbox for the password reset link.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green.shade50,
        colorText: Colors.green.shade800,
        icon: Icon(Icons.check_circle_rounded, color: Colors.green.shade600),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        duration: const Duration(seconds: 4),
      );
    } catch (e) {
      _showError(_cleanErrorMessage(e));
    }
  }

  // ── Helpers ─────────────────────────────────────────────────────────────

  String _cleanErrorMessage(Object e) {
    final msg = e.toString();
    if (msg.startsWith('Exception: ')) return msg.substring(11);
    return msg;
  }

  void _showError(String message) {
    Get.snackbar(
      'Oops!',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red.shade50,
      colorText: Colors.red.shade800,
      icon: Icon(Icons.error_outline_rounded, color: Colors.red.shade600),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 4),
    );
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
