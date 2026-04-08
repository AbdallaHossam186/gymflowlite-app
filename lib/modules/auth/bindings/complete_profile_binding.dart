import 'package:get/get.dart';
import 'package:gymflow_lite/core/services/auth_service.dart';
import 'package:gymflow_lite/core/services/firestore_service.dart';
import 'package:gymflow_lite/modules/auth/controllers/complete_profile_controller.dart';

class CompleteProfileBinding extends Bindings {
  @override
  void dependencies() {
    final authService = AuthService();
    final firestoreService = FirestoreService();

    Get.lazyPut<CompleteProfileController>(
      () => CompleteProfileController(
        firestoreService,
        authService,
      ),
    );
  }
}
