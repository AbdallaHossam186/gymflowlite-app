import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymflow_lite/core/services/image_picker_service.dart';
import 'package:gymflow_lite/modules/auth/data/models/discipline_model.dart';
import 'package:gymflow_lite/modules/auth/data/repositories/auth_repository.dart';
import 'package:gymflow_lite/routes/app_routes.dart';

class RegisterController extends GetxController {
  final AuthRepository _repo;
  final ImagePickerService _imagePicker = ImagePickerService();

  RegisterController(this._repo);

  final RxBool isLoading = false.obs;
  final RxBool isImageUploading = false.obs;
  final RxString imageUrl = ''.obs;
  final Rx<File?> selectedImage = Rx<File?>(null);

  final RxInt currentStep = 0.obs;
  final RxBool obscurePassword = true.obs;
  final RxBool obscureConfirmPassword = true.obs;
  final RxBool isLastStep = false.obs;

  final RxBool enableBiometrics = false.obs;
  final RxBool enable2FA = false.obs;

  final RxString selectedGender = ''.obs;
  final RxString selectedGym = ''.obs;
  final RxString selectedFitnessLevel = ''.obs;

  // Schedule preferences
  final RxList<String> preferredDays = <String>[].obs;
  final RxList<String> preferredTimes = <String>[].obs;

  final formKeyStep1 = GlobalKey<FormState>();
  final formKeyStep2 = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  final bioController = TextEditingController();

  final disciplines = <DisciplineItem>[
    DisciplineItem(label: 'Cardio', icon: Icons.bolt_rounded),
    DisciplineItem(label: 'Strength', icon: Icons.fitness_center_rounded),
    DisciplineItem(label: 'Yoga', icon: Icons.self_improvement_rounded),
    DisciplineItem(label: 'CrossFit', icon: Icons.timer_rounded),
    DisciplineItem(label: 'Swimming', icon: Icons.pool_rounded),
    DisciplineItem(label: 'Other', icon: Icons.more_horiz_rounded),
  ].obs;

  List<String> get selectedLabels =>
      disciplines.where((d) => d.selected).map((d) => d.label).toList();

  void toggle(int index) {
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

  bool validateStep1() {
    if (!(formKeyStep1.currentState?.validate() ?? false)) return false;
    if (selectedLabels.length < 2) {
      _showError('Please select at least 2 training disciplines.');
      return false;
    }
    return true;
  }

  bool validateStep2() => formKeyStep2.currentState?.validate() ?? false;

  Future<void> advanceOrRegister() async {
    if (currentStep.value < 1) {
      if (!validateStep1()) return;
      currentStep.value++;
      isLastStep.value = currentStep.value == 1;
    } else {
      if (!validateStep2()) return;
      await register();
    }
  }

  Future<void> register() async {
    try {
      isLoading.value = true;
      await _repo.register(
        phone: phoneController.text.trim().isNotEmpty ? phoneController.text.trim() : null,
        bio: bioController.text.trim().isNotEmpty ? bioController.text.trim() : null,
        email: emailController.text.trim(),
        password: passwordController.text,
        name: nameController.text.trim(),
        gender: selectedGender.value.isNotEmpty ? selectedGender.value : null,
        gymName: selectedGym.value.isNotEmpty ? selectedGym.value : null,
        fitnessLevel: selectedFitnessLevel.value.isNotEmpty ? selectedFitnessLevel.value : null,
        workoutTypes: selectedLabels.isNotEmpty ? selectedLabels : null,
        preferredDays: preferredDays.isNotEmpty ? preferredDays.toList() : null,
        preferredTimes: preferredTimes.isNotEmpty ? preferredTimes.toList() : null,
        profileImage: selectedImage.value,
      );
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      _showError(_cleanErrorMessage(e));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickProfilePicture(int methodId) async {
    isImageUploading.value = true;
    final File? image = methodId == 0
        ? await _imagePicker.pickImageFromCamera()
        : await _imagePicker.pickImageFromGallery();
    if (image != null) {
      selectedImage.value = image;
      Get.back();
    } else {
      Get.snackbar('No Image', 'No image was selected. Please try again.',
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.all(16),
          borderRadius: 12);
    }
    isImageUploading.value = false;
  }

  String _cleanErrorMessage(Object e) {
    final msg = e.toString();
    return msg.startsWith('Exception: ') ? msg.substring(11) : msg;
  }

  void _showError(String message) {
    Get.snackbar('Oops!', message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.shade50,
        colorText: Colors.red.shade800,
        icon: Icon(Icons.error_outline_rounded, color: Colors.red.shade600),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        duration: const Duration(seconds: 4));
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    bioController.dispose();
    super.onClose();
  }
}
