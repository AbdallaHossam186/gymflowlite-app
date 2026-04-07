import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymflow_lite/core/utils/validators.dart';
import 'package:gymflow_lite/modules/auth/controllers/login_controller.dart';
import 'package:gymflow_lite/widgets/labeled_textfield.dart';
import 'package:gymflow_lite/widgets/rounded_button.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final emailController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final isLoading = false.obs;

    Future<void> handleResetPassword() async {
      if (!(formKey.currentState?.validate() ?? false)) return;

      try {
        isLoading.value = true;
        // Use the LoginController if available, otherwise call repo directly
        final loginController = Get.find<LoginController>();
        await loginController.resetPassword(emailController.text.trim());
      } catch (e) {
        // If LoginController is not found, show a generic error
        Get.snackbar(
          'Error',
          'Unable to send reset email. Please try again.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.shade50,
          colorText: Colors.red.shade800,
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
        );
      } finally {
        isLoading.value = false;
      }
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 22,
            color: theme.colorScheme.primary,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Forgot Password',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: theme.colorScheme.primary,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),

                Container(
                  height: 110,
                  width: 110,
                  decoration: BoxDecoration(
                    color: theme.primaryColor.withValues(alpha: 0.08),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.lock_reset_rounded,
                    color: theme.primaryColor,
                    size: 48,
                  ),
                ),

                const SizedBox(height: 32),

                // Title
                Text(
                  'Forgot Password',
                  style: theme.textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 16),

                // Subtitle
                Text(
                  'Enter your email to receive a password\nreset link.',
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: Colors.black54,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 36),

                // Email TextField
                LabeledTextField(
                  label: 'EMAIL ADDRESS',
                  hint: 'name@example.com',
                  prefixIcon: Icons.email_outlined,
                  controller: emailController,
                  validator: Validators.validateEmail,
                ),

                const SizedBox(height: 36),

                // Send Button
                Obx(
                  () => RoundedButton(
                    onPressed:
                        isLoading.value ? null : () => handleResetPassword(),
                    child: isLoading.value
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text('Send Reset Link'),
                  ),
                ),

                const SizedBox(height: 28),

                // Back to login
                InkWell(
                  onTap: () => Get.back(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.chevron_left_rounded,
                        size: 20,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'BACK TO SIGN IN',
                        style: TextStyle(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
