import 'package:get/get.dart';
import 'package:gymflow_lite/core/services/auth_service.dart';
import 'package:gymflow_lite/core/services/firestore_service.dart';
import 'package:gymflow_lite/modules/auth/controllers/login_controller.dart';
import 'package:gymflow_lite/modules/auth/data/repositories/auth_repository.dart';
import 'package:gymflow_lite/modules/auth/data/repositories/upload_repository.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    final authService = AuthService();
    final firestoreService = FirestoreService();
    final uploadRepo = UploadRepository();
    final authRepo = AuthRepository(authService, firestoreService, uploadRepo);

    Get.lazyPut(() => LoginController(authRepo));
  }
}
