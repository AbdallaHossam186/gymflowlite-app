import 'package:get/get.dart';
import 'package:gymflow_lite/modules/onboarding/controllers/onboarding_controller.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OnboardingController());
  }
}
