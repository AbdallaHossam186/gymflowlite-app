import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymflow_lite/core/services/auth_service.dart';
import 'package:gymflow_lite/core/services/firestore_service.dart';
import 'package:gymflow_lite/modules/auth/data/models/discipline_model.dart';
import 'package:gymflow_lite/routes/app_routes.dart';

class CompleteProfileController extends GetxController {
  final FirestoreService _firestoreService;
  final AuthService _authService;

  CompleteProfileController(this._firestoreService, this._authService);

  final RxBool isLoading = false.obs;

  final RxInt currentStep = 0.obs;

  // Form State
  final phoneController = TextEditingController();
  final bioController = TextEditingController();

  final RxString selectedGender = 'Male'.obs;
  final RxString selectedGym = ''.obs;
  final RxString selectedFitnessLevel = ''.obs;
  final RxBool isLookingForPartner = false.obs;

  final RxList<String> preferredDays = <String>[].obs;
  final RxList<String> preferredTimes = <String>[].obs;

  final disciplines = <DisciplineItem>[
    DisciplineItem(label: 'Cardio', icon: Icons.bolt_rounded),
    DisciplineItem(label: 'Strength', icon: Icons.fitness_center_rounded),
    DisciplineItem(label: 'Yoga', icon: Icons.self_improvement_rounded),
    DisciplineItem(label: 'CrossFit', icon: Icons.timer_rounded),
    DisciplineItem(label: 'Swimming', icon: Icons.pool_rounded),
    DisciplineItem(label: 'Other', icon: Icons.more_horiz_rounded),
  ].obs;

  List<String> get selectedWorkoutTypes =>
      disciplines.where((d) => d.selected).map((d) => d.label).toList();

  void toggleDiscipline(int index) {
    disciplines[index].selected = !disciplines[index].selected;
    disciplines.refresh();
  }

  void toggleDay(String day) {
    if (preferredDays.contains(day)) {
      preferredDays.remove(day);
    } else {
      preferredDays.add(day);
    }
  }

  void toggleTime(String time) {
    if (preferredTimes.contains(time)) {
      preferredTimes.remove(time);
    } else {
      preferredTimes.add(time);
    }
  }

  Future<void> submitProfile() async {
    final user = _authService.currentUser;
    if (user == null) {
      Get.snackbar('Error', 'User not logged in');
      return;
    }

    try {
      isLoading.value = true;
      final updateData = {
        'phone': phoneController.text.trim().isNotEmpty
            ? phoneController.text.trim()
            : null,
        'bio': bioController.text.trim().isNotEmpty
            ? bioController.text.trim()
            : null,
        'gender': selectedGender.value.isNotEmpty ? selectedGender.value : null,
        'gymName': selectedGym.value.isNotEmpty ? selectedGym.value : null,
        'fitnessLevel': selectedFitnessLevel.value.isNotEmpty
            ? selectedFitnessLevel.value
            : null,
        'workoutTypes': selectedWorkoutTypes.isNotEmpty
            ? selectedWorkoutTypes
            : null,
        'preferredDays': preferredDays.isNotEmpty ? preferredDays : null,
        'preferredTimes': preferredTimes.isNotEmpty ? preferredTimes : null,
        'isLookingForPartner': isLookingForPartner.value,
      };

      await _firestoreService.updateUserProfile(user.uid, updateData);

      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      Get.snackbar(
        'Oops!',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.shade50,
        colorText: Colors.red.shade800,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        duration: const Duration(seconds: 4),
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    phoneController.dispose();
    bioController.dispose();
    super.onClose();
  }
}
