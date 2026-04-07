import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymflow_lite/core/utils/validators.dart';
import 'package:gymflow_lite/modules/auth/controllers/register_controller.dart';
import 'package:gymflow_lite/widgets/labeled_textfield.dart';

class RegisterViewStep2 extends GetView<RegisterController> {
  const RegisterViewStep2({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: controller.formKeyStep2,
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),

                // ── Hero Header ──────────────────────────────────────────
                _HeroHeader(colorScheme: colorScheme, theme: theme),
                const SizedBox(height: 32),

                // ── Password Fields ──────────────────────────────────────
                _SectionLabel(label: 'Password', theme: theme),
                const SizedBox(height: 10),
                LabeledTextField(
                  prefixIcon: Icons.lock_outline,
                  label: 'PASSWORD',
                  hint: '••••••••',
                  controller: controller.passwordController,
                  isPassword: true,
                  obscureText: controller.obscurePassword,
                  needForgotPassword: false,
                  validator: Validators.validatePassword,
                ),
                const SizedBox(height: 8),
                LabeledTextField(
                  prefixIcon: Icons.lock_outline,
                  obscureText: controller.obscureConfirmPassword,
                  label: 'CONFIRM PASSWORD',
                  hint: '••••••••',
                  controller: controller.confirmPasswordController,
                  isPassword: true,
                  needForgotPassword: false,
                  validator: (value) => Validators.validateConfirmPassword(
                    value,
                    controller.passwordController.text,
                  ),
                ),
                const SizedBox(height: 28),

                // ── Security Options ─────────────────────────────────────
                _SectionLabel(label: 'Security Options', theme: theme),
                const SizedBox(height: 10),

                _BiometricCard(
                  theme: theme,
                  colorScheme: colorScheme,
                  controller: controller,
                ),
                const SizedBox(height: 12),

                _TwoFactorCard(
                  theme: theme,
                  colorScheme: colorScheme,
                  controller: controller,
                ),
                const SizedBox(height: 32),
              ],
            ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Hero Header ────────────────────────────────────────────────────────────────
class _HeroHeader extends StatelessWidget {
  const _HeroHeader({required this.colorScheme, required this.theme});

  final ColorScheme colorScheme;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colorScheme.primary,
                colorScheme.primary.withValues(alpha: 0.7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: colorScheme.primary.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(
            Icons.shield_outlined,
            color: Colors.white,
            size: 32,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Protect Your\nAccount',
                style: theme.textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w800,
                  height: 1.15,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Add an extra layer of security to keep your training data safe.',
                style: theme.textTheme.bodySmall!.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.55),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Section Label ──────────────────────────────────────────────────────────────
class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label, required this.theme});

  final String label;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: theme.textTheme.labelLarge!.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: 0.2,
        color: theme.colorScheme.onSurface.withValues(alpha: 0.45),
      ),
    );
  }
}

// ── Biometric Card ─────────────────────────────────────────────────────────────
class _BiometricCard extends StatelessWidget {
  const _BiometricCard({
    required this.theme,
    required this.colorScheme,
    required this.controller,
  });

  final ThemeData theme;
  final ColorScheme colorScheme;
  final RegisterController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isEnabled = controller.enableBiometrics.value;
      return AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isEnabled
                ? colorScheme.primary.withValues(alpha: 0.4)
                : colorScheme.outline.withValues(alpha: 0.15),
            width: isEnabled ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isEnabled
                  ? colorScheme.primary.withValues(alpha: 0.08)
                  : Colors.black.withValues(alpha: 0.03),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: isEnabled
                          ? colorScheme.primary.withValues(alpha: 0.12)
                          : colorScheme.onSurface.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      Icons.fingerprint,
                      size: 26,
                      color: isEnabled
                          ? colorScheme.primary
                          : colorScheme.onSurface.withValues(alpha: 0.4),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Biometric Login',
                          style: theme.textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 2),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: Text(
                            isEnabled ? 'Active' : 'Tap to enable',
                            key: ValueKey(isEnabled),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: isEnabled
                                  ? colorScheme.primary
                                  : colorScheme.onSurface.withValues(
                                      alpha: 0.4,
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch.adaptive(
                    value: isEnabled,
                    onChanged: (val) => controller.enableBiometrics.value = val,
                    activeThumbColor: colorScheme.primary,
                  ),
                ],
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                child: isEnabled
                    ? Padding(
                        padding: const EdgeInsets.only(top: 14),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: colorScheme.primary.withValues(alpha: 0.06),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline_rounded,
                                size: 16,
                                color: colorScheme.primary.withValues(
                                  alpha: 0.7,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Use FaceID or fingerprint to access your dashboard instantly.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    height: 1.4,
                                    color: colorScheme.onSurface.withValues(
                                      alpha: 0.6,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      );
    });
  }
}

// ── Two-Factor Auth Card ────────────────────────────────────────────────────────
class _TwoFactorCard extends StatelessWidget {
  const _TwoFactorCard({
    required this.theme,
    required this.colorScheme,
    required this.controller,
  });

  final ThemeData theme;
  final ColorScheme colorScheme;
  final RegisterController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isEnabled = controller.enable2FA.value;
      return AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isEnabled
                ? colorScheme.primary.withValues(alpha: 0.4)
                : colorScheme.outline.withValues(alpha: 0.15),
            width: isEnabled ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isEnabled
                  ? colorScheme.primary.withValues(alpha: 0.08)
                  : Colors.black.withValues(alpha: 0.03),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: isEnabled
                          ? colorScheme.primary.withValues(alpha: 0.12)
                          : colorScheme.onSurface.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      isEnabled
                          ? Icons.verified_user_rounded
                          : Icons.smartphone_rounded,
                      size: 24,
                      color: isEnabled
                          ? colorScheme.primary
                          : colorScheme.onSurface.withValues(alpha: 0.4),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Two-Factor Auth',
                          style: theme.textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Verify via SMS code',
                          style: TextStyle(
                            fontSize: 12,
                            color: colorScheme.onSurface.withValues(alpha: 0.4),
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: isEnabled
                        ? Icon(
                            Icons.check_circle_rounded,
                            key: const ValueKey('check'),
                            color: colorScheme.primary,
                            size: 24,
                          )
                        : Container(
                            key: const ValueKey('badge'),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.tertiary.withValues(
                                alpha: 0.12,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'RECOMMENDED',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.8,
                                color: colorScheme.tertiary,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                isEnabled
                    ? "2FA is active. We'll verify your identity on new devices."
                    : "We'll send a code to your phone when logging in from a new device.",
                style: TextStyle(
                  fontSize: 13,
                  height: 1.5,
                  color: colorScheme.onSurface.withValues(alpha: 0.55),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: isEnabled
                      ? OutlinedButton.icon(
                          key: const ValueKey('enabled'),
                          onPressed: () => controller.enable2FA.value = false,
                          icon: const Icon(Icons.check_rounded, size: 18),
                          label: const Text('2FA Enabled'),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: colorScheme.primary.withValues(
                                alpha: 0.35,
                              ),
                            ),
                            foregroundColor: colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        )
                      : FilledButton.icon(
                          key: const ValueKey('disabled'),
                          onPressed: () => controller.enable2FA.value = true,
                          icon: const Icon(Icons.shield_rounded, size: 18),
                          label: const Text('Enable 2FA'),
                          style: FilledButton.styleFrom(
                            backgroundColor: colorScheme.primary,
                            foregroundColor: colorScheme.onPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
