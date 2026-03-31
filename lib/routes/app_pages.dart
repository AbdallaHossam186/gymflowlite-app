import 'package:get/get.dart';
import 'package:gymflow_lite/modules/splash_screen/binding/splash_binding.dart';
import 'package:gymflow_lite/modules/splash_screen/views/splash_page.dart';

import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    // GetPage(name: AppRoutes.home, page: () => HomeView()),
  ];
}
