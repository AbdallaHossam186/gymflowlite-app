import 'package:get/get.dart';
import 'package:gymflow_lite/core/services/auth_service.dart';
import 'package:gymflow_lite/routes/app_routes.dart';

class AuthController extends GetxController {
  final AuthService _auth = AuthService();

  @override
  void onInit() {
    super.onInit();

    // Listen to silent login + logout
    _auth.authStateChanges.listen((user) {
      if (user == null) {
        Get.offAllNamed(AppRoutes.login);
      } else {
        Get.offAllNamed(AppRoutes.home);
      }
    });
  }
}
