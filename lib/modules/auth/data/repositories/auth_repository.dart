import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:gymflow_lite/core/services/auth_service.dart';
import 'package:gymflow_lite/core/services/firestore_service.dart';
import 'package:gymflow_lite/modules/auth/data/models/user_model.dart';
import 'package:gymflow_lite/modules/auth/data/repositories/upload_repository.dart';

class AuthRepository {
  final AuthService _authService;
  final FirestoreService _firestoreService;
  final UploadRepository _uploadRepository;

  AuthRepository(
    this._authService,
    this._firestoreService,
    this._uploadRepository,
  );

  // ── Login with Email ────────────────────────────────────────────────────

  Future<UserModel> login(String email, String password) async {
    final credential = await _authService.loginWithEmail(email, password);
    final uid = credential.user!.uid;

    final profile = await _firestoreService.getUserProfile(uid);
    if (profile == null) {
      throw Exception('User profile not found. Please register first.');
    }
    return profile;
  }

  // ── Register with Email ─────────────────────────────────────────────────

  Future<UserModel> register({
    required String email,
    required String password,
    required String name,
    String? gender,
    String? gymName,
    List<String>? workoutTypes,
    File? profileImage,
  }) async {
    // 1. Create Firebase Auth user
    debugPrint('[AuthRepo] Creating Firebase Auth user...');
    final credential = await _authService.registerWithEmail(email, password);
    final uid = credential.user!.uid;
    debugPrint('[AuthRepo] Auth user created with UID: $uid');

    // 2. Upload profile picture if provided
    String? photoUrl;
    if (profileImage != null) {
      debugPrint('[AuthRepo] Profile image provided, starting upload...');
      try {
        photoUrl = await _uploadRepository.uploadProfilePicture(
          profileImage,
          uid,
        );
        debugPrint('[AuthRepo] Upload succeeded. photoUrl: $photoUrl');
      } catch (e) {
        // Don't block registration if upload fails
        debugPrint('[AuthRepo] Upload failed (non-fatal): $e');
      }
    } else {
      debugPrint('[AuthRepo] No profile image provided, skipping upload.');
    }

    // 3. Create Firestore user document
    debugPrint('[AuthRepo] Creating Firestore user profile...');
    final user = UserModel(
      id: uid,
      name: name,
      email: email,
      photoUrl: photoUrl,
      gender: gender,
      gymName: gymName,
      workoutTypes: workoutTypes,
      createdAt: DateTime.now(),
      lastActive: DateTime.now(),
    );

    await _firestoreService.createUserProfile(user);
    debugPrint('[AuthRepo] Firestore profile created. photoUrl in doc: $photoUrl');
    return user;
  }

  // ── Login with Google ───────────────────────────────────────────────────

  Future<UserModel> loginWithGoogle() async {
    final credential = await _authService.loginWithGoogle();
    final firebaseUser = credential.user!;
    final uid = firebaseUser.uid;

    // Check if Firestore profile already exists
    final existingProfile = await _firestoreService.getUserProfile(uid);
    if (existingProfile != null) {
      return existingProfile;
    }

    // First-time Google sign-in: create profile from Google account data
    final user = UserModel(
      id: uid,
      name: firebaseUser.displayName ?? 'User',
      email: firebaseUser.email ?? '',
      photoUrl: firebaseUser.photoURL,
      createdAt: DateTime.now(),
      lastActive: DateTime.now(),
    );

    await _firestoreService.createUserProfile(user);
    return user;
  }

  // ── Password Reset ──────────────────────────────────────────────────────

  Future<void> resetPassword(String email) =>
      _authService.resetPassword(email);

  // ── Sign Out ────────────────────────────────────────────────────────────

  Future<void> signOut() => _authService.signOut();
}
