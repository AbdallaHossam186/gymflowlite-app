import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashController extends GetxController {
  late PackageInfo packageInfo;

  @override
  void onInit() {
    super.onInit();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    packageInfo = await PackageInfo.fromPlatform();
  }
}
