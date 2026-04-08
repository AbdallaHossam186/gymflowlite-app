import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymflow_lite/core/utils/validators.dart';
import 'package:gymflow_lite/modules/auth/compnents/gym_selection_bottomsheet.dart';
import 'package:gymflow_lite/modules/auth/compnents/training_discipline_selector.dart';
import 'package:gymflow_lite/modules/auth/compnents/upload_image_bottomsheet.dart';
import 'package:gymflow_lite/modules/auth/controllers/register_controller.dart';
import 'package:gymflow_lite/widgets/gender_selection.dart';
import 'package:gymflow_lite/widgets/labeled_textfield.dart';

class RegisterViewStep1 extends GetView<RegisterController> {
  const RegisterViewStep1({super.key});

  // Design-system colours

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      // ── AppBar ──────────────────────────────────────────────────────────

      // ── Body ────────────────────────────────────────────────────────────
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Form(
            key: controller.formKeyStep1,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Avatar ──────────────────────────────────────────────
                  Center(
                    child: Column(
                      children: [
                        Obx(
                          () => Stack(
                            clipBehavior: Clip.none,
                            children: [
                              InkWell(
                                onTap: controller.selectedImage.value == null
                                    ? () {
                                        Get.bottomSheet(
                                          UploadImageBottomsheet(
                                            controller: controller,
                                          ),
                                        );
                                      }
                                    : null,
                                child: Container(
                                  width: 112,
                                  height: 112,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: const Color(0xFFE1E2E6),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 4,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.12,
                                        ),
                                        blurRadius: 24,
                                        offset: const Offset(0, 8),
                                      ),
                                    ],
                                  ),
                                  child: controller.selectedImage.value == null
                                      ? const Icon(
                                          Icons.add_a_photo_rounded,
                                          color: Color(0xFF777587),
                                          size: 36,
                                        )
                                      : ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            56,
                                          ),
                                          child: Image.file(
                                            controller.selectedImage.value!,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: controller.selectedImage.value == null
                                    ? SizedBox.shrink()
                                    : InkWell(
                                        onTap: () {
                                          Get.bottomSheet(
                                            UploadImageBottomsheet(
                                              controller: controller,
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: theme.primaryColor,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x40675DF9),
                                                blurRadius: 8,
                                                offset: Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: const Icon(
                                            Icons.edit_rounded,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Upload your best self',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                            letterSpacing: -0.2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Members with photos get 3x more cheers',
                          style: TextStyle(
                            fontSize: 13,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // ── Full Name ────────────────────────────────────────────
                  // _SectionLabel(text: ),
                  const SizedBox(height: 8),
                  LabeledTextField(
                    prefixIcon: Icons.person_outline_rounded,
                    controller: controller.nameController,
                    label: 'Your Full Name',
                    hint: 'Alex Rivera',
                    validator: Validators.validateName,
                  ),

                  const SizedBox(height: 28),
                  LabeledTextField(
                    prefixIcon: Icons.email_outlined,
                    controller: controller.emailController,
                    label: 'Email Address',
                    hint: 'name@example.com',
                    validator: Validators.validateEmail,
                  ),

                  const SizedBox(height: 28),

                  // ── Gender ───────────────────────────────────────────────
                  GenderSelection(),

                  const SizedBox(height: 28),

                  // ── Gym Selection ────────────────────────────────────────
                  Text(
                    'Primary Gym Hub',
                    style: theme.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      Get.bottomSheet(
                        backgroundColor: theme.scaffoldBackgroundColor,
                        ignoreSafeArea: false,
                        GymSelectionBottomsheet(controller: controller),
                        isScrollControlled: true,
                      );
                    },
                    child: _GymSelector(),
                  ),

                  const SizedBox(height: 28),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Fitness Level',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Obx(
                        () => DropdownButtonFormField<String>(
                          initialValue:
                              controller.selectedFitnessLevel.value.isEmpty
                              ? null
                              : controller.selectedFitnessLevel.value,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 18,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          hint: const Text('Select your fitness level'),
                          items:
                              [
                                    'Beginner',
                                    'Intermediate',
                                    'Advanced',
                                    'Professional',
                                  ]
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (val) {
                            if (val != null) {
                              controller.selectedFitnessLevel.value = val;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // ── Training Discipline ──────────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Training Discipline',
                        style: theme.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        'PICK AT LEAST 2',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurfaceVariant,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TrainingDisciplineGrid(
                    disciplines: controller.disciplines,
                    onToggle: controller.toggle,
                  ),

                  const SizedBox(height: 32),

                  // ── Privacy hint ─────────────────────────────────────────
                  _PrivacyHint(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GymSelector extends GetView<RegisterController> {
  static const Color _containerLow = Color(0xFFF2F3F7);
  static const Color _outline = Color(0xFF777587);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Obx(() {
      final hasSelection = controller.selectedGym.value.isNotEmpty;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dropdown trigger
          Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: hasSelection
                  ? theme.primaryColor.withValues(alpha: 0.06)
                  : _containerLow,
              borderRadius: BorderRadius.circular(16),
              border: hasSelection
                  ? Border.all(
                      color: theme.primaryColor.withValues(alpha: 0.3),
                      width: 1.5,
                    )
                  : null,
            ),
            child: Row(
              children: [
                Icon(
                  hasSelection
                      ? Icons.fitness_center_rounded
                      : Icons.stadium_outlined,
                  color: hasSelection ? theme.primaryColor : _outline,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    hasSelection
                        ? controller.selectedGym.value
                        : 'Select your local gym...',
                    style: TextStyle(
                      color: hasSelection ? Colors.black87 : _outline,
                      fontSize: 14,
                      fontWeight: hasSelection
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ),
                Icon(
                  Icons.expand_more_rounded,
                  color: hasSelection ? theme.primaryColor : _outline,
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}

class _PrivacyHint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF2FF).withValues(alpha: 0.6), // indigo-50/50
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 6,
                ),
              ],
            ),
            child: const Icon(
              Icons.verified_rounded,
              color: Color(0xFF4D41DF),
              size: 22,
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Private & Secure',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E1B6B), // indigo-900
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Your data is only used to tailor your personal workout recommendations. You can change this later in settings.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF4338CA), // indigo-800 at 70%
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
