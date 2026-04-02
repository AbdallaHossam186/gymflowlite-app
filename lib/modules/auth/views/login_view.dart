import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymflow_lite/modules/auth/controllers/login_controller.dart';
import 'package:gymflow_lite/routes/app_routes.dart';
import 'package:gymflow_lite/widgets/labeled_textfield.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF0F1F7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),

              // ── Logo circle ───────────────────────────────────────────────
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 100,
                  height: 100,
                ),
              ),

              const SizedBox(height: 24),

              // ── App name ──────────────────────────────────────────────────
              Text(
                'GymFlow Lite',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 38,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 8),

              // ── Subtitle ──────────────────────────────────────────────────
              Text(
                'Your editorial fitness journey begins here.',
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium!.copyWith(
                  color: Colors.blueGrey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 40),

              // ── Google button ─────────────────────────────────────────────
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  onPressed: () {
                    // Handle Google sign-in
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.grey.shade200, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Google "G" logo using coloured text as a stand-in
                      // Replace with Image.asset if you have the Google logo asset
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Image.asset(
                          'assets/images/google.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Continue with Google',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // ── OR USE EMAIL divider ───────────────────────────────────────
              Row(
                children: [
                  Expanded(
                    child: Divider(color: Colors.grey.shade300, thickness: 1),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'OR USE EMAIL',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(color: Colors.grey.shade300, thickness: 1),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              LabeledTextField(
                prefixIcon: Icons.email_outlined,
                label: 'EMAIL ADDRESS',
                hint: 'name@example.com',
                controller: controller.emailController,
              ),

              const SizedBox(height: 20),

              LabeledTextField(
                onForgotPassword: () {
                  Get.toNamed(
                    AppRoutes.forgotPassword,
                  ); // Navigate to forgot password
                },
                prefixIcon: Icons.lock_outline,
                label: 'PASSWORD',
                hint: '••••••••',
                controller: controller.passwordController,
                isPassword: true,
                obscureText: controller.obscurePassword,
              ),

              const SizedBox(height: 32),

              // ── Sign In button ────────────────────────────────────────────
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle sign in
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5B5BD6),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Sign In to Dashboard',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // ── Create account link ───────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(fontSize: 15, color: Colors.black54),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.register); // Navigate to register
                      // Navigate to register
                    },
                    child: const Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF5B5BD6),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Minimal Google "G" logo painter ──────────────────────────────────────────
