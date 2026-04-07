import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gymflow_lite/modules/auth/controllers/register_controller.dart';
import 'package:gymflow_lite/modules/auth/views/register_view_step1.dart';
import 'package:gymflow_lite/modules/auth/views/register_view_step2.dart';
import 'package:gymflow_lite/widgets/rounded_button.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      // ── AppBar ──────────────────────────────────────────────────────────
      appBar: AppBar(
        elevation: 0,
        shadowColor: theme.colorScheme.primary.withValues(alpha: 0.05),
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left_rounded,
            size: 28,
            color: theme.colorScheme.primary,
          ),
          onPressed: () {
            if (controller.currentStep.value > 0) {
              controller.currentStep.value--;
              controller.isLastStep.value = false;
            } else {
              Get.back();
            }
          },
        ),
        title: Text(
          'Complete Profile',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Obx(
                () => Text(
                  'STEP ${controller.currentStep.value + 1} OF 2',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurfaceVariant,
                    letterSpacing: 1.4,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      body: Obx(
        () => IndexedStack(
          index: controller.currentStep.value,
          children: [RegisterViewStep1(), RegisterViewStep2()],
        ),
      ),

      // ── Sticky Continue Button ───────────────────────────────────────────
      bottomNavigationBar: SafeArea(
        child: SizedBox(
          height: 80,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(
              () => Row(
                children: [
                  AnimatedOpacity(
                    opacity: controller.currentStep.value > 0 ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: controller.currentStep.value > 0
                        ? TextButton(
                            onPressed: () {
                              if (controller.currentStep.value > 0) {
                                controller.currentStep.value--;
                                controller.isLastStep.value = false;
                              }
                            },
                            child: Text(
                              'BACK',
                              style: TextStyle(
                                color: Colors.blueGrey.shade400,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                  Expanded(
                    child: AnimatedAlign(
                      alignment: Alignment.centerRight,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: SizedBox(
                        width: controller.currentStep.value > 0
                            ? MediaQuery.of(context).size.width * 0.62
                            : double.infinity,
                        height: 56,
                        child: RoundedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : () => controller.advanceOrRegister(),
                          child: controller.isLoading.value
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.isLastStep.value
                                          ? 'Get Started'
                                          : 'Continue',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Icon(Icons.arrow_forward, size: 24),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
