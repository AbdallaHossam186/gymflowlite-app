import 'package:get/get.dart';
import 'package:gymflow_lite/routes/app_routes.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashController extends GetxController {
  late PackageInfo packageInfo;

  @override
  void onInit() {
    super.onInit();
    _initPackageInfo(); // async call, but we don’t await here
  }

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(AppRoutes.onboarding);
    });
  }

  Future<void> _initPackageInfo() async {
    packageInfo = await PackageInfo.fromPlatform();
  }
}
