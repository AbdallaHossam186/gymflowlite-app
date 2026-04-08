import 'package:get/get.dart';
import 'package:gymflow_lite/core/services/auth_service.dart';
import 'package:gymflow_lite/routes/app_routes.dart';

class HomeController extends GetxController {
  final AuthService _authService = AuthService();

  Future<void> signOut() async {
    await _authService.signOut();
    Get.offAllNamed(AppRoutes.login);
  }
}
