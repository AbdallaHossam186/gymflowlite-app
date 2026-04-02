import 'package:get/get.dart';
import 'package:gymflow_lite/modules/auth/bindings/login_binding.dart';
import 'package:gymflow_lite/modules/auth/bindings/register_binding.dart';
import 'package:gymflow_lite/modules/auth/views/forget_password_view.dart';
import 'package:gymflow_lite/modules/auth/views/login_view.dart';
import 'package:gymflow_lite/modules/auth/views/register_view.dart';
import 'package:gymflow_lite/modules/onboarding/views/onboarding_view.dart';
import 'package:gymflow_lite/modules/splash_screen/binding/splash_binding.dart';
import 'package:gymflow_lite/modules/splash_screen/views/splash_page.dart';

import '../modules/onboarding/binding/onboarding_binding.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgetPasswordView(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    // GetPage(name: AppRoutes.home, page: () => HomeView()),
  ];
}
