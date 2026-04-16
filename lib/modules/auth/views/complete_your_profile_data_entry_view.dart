import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymflow_lite/modules/auth/compnents/gym_selection_bottomsheet.dart';
import 'package:gymflow_lite/modules/auth/controllers/complete_profile_controller.dart';
import 'package:gymflow_lite/widgets/rounded_button.dart';
import 'package:gymflow_lite/widgets/labeled_textfield.dart';
import 'package:gymflow_lite/widgets/gender_selection.dart';
import 'package:gymflow_lite/modules/auth/compnents/training_discipline_selector.dart';

class CompleteYourProfileDataEntryView
    extends GetView<CompleteProfileController> {
  const CompleteYourProfileDataEntryView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Welcome to GymFlow!",
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Since you signed in with Google, we just need a few more details to find your perfect training partner.",
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium!.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),

            LabeledTextField(
              label: 'Phone Number',
              hint: 'e.g. +1 234 567 8900',
              controller: controller.phoneController,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),

            LabeledTextField(
              label: 'Bio',
              hint: 'Tell us a bit about yourself...',
              controller: controller.bioController,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 24),

            Obx(
              () => GenderSelection(
                initialValue: controller.selectedGender.value.isEmpty
                    ? 'Male'
                    : controller.selectedGender.value,
                onChanged: (val) => controller.selectedGender.value = val,
              ),
            ),
            const SizedBox(height: 24),

            // Gym Name Selection (simplified text field for now)
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
            const SizedBox(height: 24),

            // Fitness Level Dropdown
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
                    initialValue: controller.selectedFitnessLevel.value.isEmpty
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
                        ['Beginner', 'Intermediate', 'Advanced', 'Professional']
                            .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)),
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
            const SizedBox(height: 24),

            const Text(
              'Preferred Workout Types',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            TrainingDisciplineGrid(
              disciplines: controller.disciplines,
              onToggle: controller.toggleDiscipline,
            ),

            const SizedBox(height: 24),

            // ── Preferred Workout Days ────────────────────────────────────
            Text(
              'Preferred Workout Days',
              style: theme.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Obx(() {
              const days = [
                'Mon',
                'Tue',
                'Wed',
                'Thu',
                'Fri',
                'Sat',
                'Sun',
              ];
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: days.map((day) {
                  final selected = controller.preferredDays.contains(day);
                  return ChoiceChip(
                    label: Text(day),
                    selected: selected,
                    onSelected: (_) => controller.toggleDay(day),
                    selectedColor: theme.colorScheme.primary,
                    labelStyle: TextStyle(
                      color: selected
                          ? theme.colorScheme.onPrimary
                          : Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                }).toList(),
              );
            }),

            const SizedBox(height: 24),

            // ── Preferred Workout Times ────────────────────────────────────
            Text(
              'Preferred Workout Times',
              style: theme.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Obx(() {
              const times = ['Morning', 'Afternoon', 'Evening', 'Night'];
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: times.map((time) {
                  final selected = controller.preferredTimes.contains(time);
                  return ChoiceChip(
                    label: Text(time),
                    selected: selected,
                    onSelected: (_) => controller.toggleTime(time),
                    selectedColor: theme.colorScheme.primary,
                    labelStyle: TextStyle(
                      color: selected
                          ? theme.colorScheme.onPrimary
                          : Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                }).toList(),
              );
            }),

            const SizedBox(height: 40),

            Obx(
              () => SizedBox(
                width: double.infinity,
                height: 62,
                child: RoundedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.submitProfile,
                  child: controller.isLoading.value
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Finish Setup",
                              style: theme.textTheme.titleMedium!.copyWith(
                                color: theme.colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.check_circle_rounded),
                          ],
                        ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class _GymSelector extends GetView<CompleteProfileController> {
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
