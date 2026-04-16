import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymflow_lite/modules/auth/controllers/complete_profile_controller.dart';
import 'package:gymflow_lite/modules/auth/views/complete_your_profile_data_entry_view.dart';
import 'package:gymflow_lite/routes/app_routes.dart';
import 'package:gymflow_lite/widgets/rounded_button.dart';

class CompleteYourProfileMainView extends GetView<CompleteProfileController> {
  const CompleteYourProfileMainView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Obx(
      () => Scaffold(
        appBar: controller.currentStep.value > 0
            ? AppBar(
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
              )
            : null,
        body: IndexedStack(
          index: controller.currentStep.value,
          children: [
            SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),

                      Container(
                        width: 340,
                        height: 340,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 50,
                              offset: const Offset(0, 20),
                              color: Colors.black.withValues(alpha: 0.06),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            "assets/images/logo.png",
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      /// TEXT HEADER
                      Text(
                        "Welcome to GymFlow!",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineMedium!.copyWith(
                          fontWeight: FontWeight.w900,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        "To help you find the perfect training partner, let's finish setting up your profile.",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge!.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 40),

                      SizedBox(
                        width: double.infinity,
                        height: 62,
                        child: RoundedButton(
                          onPressed: () {
                            controller.currentStep.value = 1;
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Complete Profile",
                                style: theme.textTheme.titleMedium!.copyWith(
                                  color: theme.colorScheme.onPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(Icons.arrow_forward_rounded),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      TextButton(
                        onPressed: () {
                          Get.offAllNamed(AppRoutes.home);
                        },
                        child: Text(
                          "Finish later",
                          style: theme.textTheme.labelLarge!.copyWith(
                            letterSpacing: 2,
                            color: theme.colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            CompleteYourProfileDataEntryView(),
          ],
        ),

        bottomNavigationBar: SafeArea(
          child: SizedBox(
            height: kToolbarHeight + 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                children: [
                  SizedBox(height: 16),
                  Obx(
                    () => Row(
                      crossAxisAlignment: .start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _StepDot(label: "Auth", active: true, theme: theme),
                        _Line(theme, controller.currentStep.value >= 1),
                        _StepDot(
                          label: "Profile",
                          active: controller.currentStep.value >= 1,
                          theme: theme,
                        ),
                        _Line(theme, controller.currentStep.value > 1),
                        _StepDot(
                          label: "Ready",
                          active: controller.currentStep.value > 1,
                          theme: theme,
                        ),
                      ],
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

/// STEP DOT COMPONENT
class _StepDot extends StatelessWidget {
  final bool active;
  final String label;
  final ThemeData theme;

  const _StepDot({
    required this.active,
    required this.label,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: active
                ? theme.colorScheme.primary
                : theme.colorScheme.outline,
            shape: BoxShape.circle,
            boxShadow: active
                ? [
                    BoxShadow(
                      blurRadius: 8,
                      color: theme.colorScheme.primary.withValues(alpha: .8),
                    ),
                  ]
                : null,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.textTheme.labelSmall!.copyWith(
            fontWeight: FontWeight.bold,
            color: active
                ? theme.colorScheme.primary
                : theme.colorScheme.outline,
          ),
        ),
      ],
    );
  }
}

/// SMALL LINE BETWEEN DOTS
class _Line extends StatelessWidget {
  final bool active;
  final ThemeData theme;
  const _Line(this.theme, this.active);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: active ? theme.colorScheme.primary : theme.colorScheme.outline,
        borderRadius: BorderRadius.circular(15),
      ),
      width: 40,
      height: 5,
      margin: const EdgeInsets.symmetric(horizontal: 6),
    );
  }
}
