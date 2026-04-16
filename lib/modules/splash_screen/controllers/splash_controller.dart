import 'package:get/get.dart';
import 'package:gymflow_lite/modules/auth/controllers/auth_controller.dart';
import 'package:gymflow_lite/routes/app_routes.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Key used to persist whether the user has seen the onboarding screens.
const _kOnboardingDoneKey = 'onboarding_completed';

class SplashController extends GetxController {
  late PackageInfo packageInfo;

  @override
  void onInit() {
    super.onInit();
    _initPackageInfo();
  }

  @override
  void onReady() {
    super.onReady();
    _navigateAfterSplash();
  }

  Future<void> _initPackageInfo() async {
    packageInfo = await PackageInfo.fromPlatform();
  }

  Future<void> _navigateAfterSplash() async {
    // Show the splash for at least 2 seconds so the animation can play.
    await Future.delayed(const Duration(seconds: 2));

    // Wait for AuthController to finish its initial auth-state check.
    // AuthController is registered permanently in SplashBinding.
    final authController = Get.find<AuthController>();
    // Poll until the async Firestore fetch is done (usually < 1 s).
    while (authController.isCheckingAuth.value) {
      await Future.delayed(const Duration(milliseconds: 100));
    }

    // ── Routing decision tree ────────────────────────────────────────────

    // 1. First-ever launch → show onboarding.
    final prefs = await SharedPreferences.getInstance();
    final onboardingDone = prefs.getBool(_kOnboardingDoneKey) ?? false;
    if (!onboardingDone) {
      Get.offAllNamed(AppRoutes.onboarding);
      return;
    }

    // 2. Not signed in → show login.
    if (!authController.isLoggedIn) {
      Get.offAllNamed(AppRoutes.login);
      return;
    }

    // 3. Signed in but profile incomplete → collect remaining details.
    if (!authController.isProfileComplete) {
      Get.offAllNamed(AppRoutes.compeleteYourProfile);
      return;
    }

    // 4. Signed in with a complete profile → go to the app.
    Get.offAllNamed(AppRoutes.home);
  }
}
