import 'package:get/get.dart';
import 'package:gymflow_lite/modules/splash_screen/controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
  }
}
