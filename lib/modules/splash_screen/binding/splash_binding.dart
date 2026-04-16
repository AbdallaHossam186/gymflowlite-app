import 'package:get/get.dart';
import 'package:gymflow_lite/modules/auth/bindings/auth_binding.dart';
import 'package:gymflow_lite/modules/splash_screen/controllers/splash_controller.dart';

/// Binds both [SplashController] and [AuthController] (permanent) so that
/// [SplashController] can always find [AuthController] via Get.find().
class SplashBinding extends Bindings {
  @override
  void dependencies() {
    // Register AuthController permanently first — it listens to Firebase
    // auth-state changes for the lifetime of the app.
    AuthBinding().dependencies();

    // SplashController is only needed during the splash screen.
    Get.put<SplashController>(SplashController());
  }
}
