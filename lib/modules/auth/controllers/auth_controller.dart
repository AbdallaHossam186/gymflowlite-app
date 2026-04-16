import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:gymflow_lite/core/services/auth_service.dart';
import 'package:gymflow_lite/core/services/firestore_service.dart';
import 'package:gymflow_lite/modules/auth/data/models/user_model.dart';

class AuthController extends GetxController {
  final AuthService _auth = AuthService();
  final FirestoreService _firestoreService = FirestoreService();

  /// The raw Firebase user (null = signed out).
  final Rxn<User> firebaseUser = Rxn<User>();

  /// The full app-level user profile from Firestore.
  final Rxn<UserModel> appUser = Rxn<UserModel>();

  /// True while the initial auth-state check is in progress.
  final RxBool isCheckingAuth = true.obs;

  /// Convenience: is the user signed in?
  bool get isLoggedIn => firebaseUser.value != null;

  /// Convenience: has the signed-in user completed their profile?
  bool get isProfileComplete => appUser.value?.isProfileComplete ?? false;

  @override
  void onInit() {
    super.onInit();

    // Listen to Firebase auth state changes (sign-in / sign-out / token refresh).
    _auth.authStateChanges.listen((user) async {
      isCheckingAuth.value = true;

      if (user == null) {
        firebaseUser.value = null;
        appUser.value = null;
      } else {
        firebaseUser.value = user;
        // Fetch Firestore profile. May return null for brand-new Google users
        // before the repository has created their document — that's expected.
        try {
          final profile = await _firestoreService.getUserProfile(user.uid);
          appUser.value = profile;
        } catch (_) {
          // Profile fetch failed (network issue / Firestore rules).
          // Leave appUser as null — login_controller handles the routing.
          appUser.value = null;
        }
      }

      isCheckingAuth.value = false;
    });
  }

  /// Refreshes the Firestore profile for the current user.
  Future<void> refreshProfile() async {
    final uid = firebaseUser.value?.uid;
    if (uid == null) return;
    appUser.value = await _firestoreService.getUserProfile(uid);
  }
}
