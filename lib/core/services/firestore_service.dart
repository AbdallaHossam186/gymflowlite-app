import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gymflow_lite/modules/auth/data/models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _usersRef =>
      _firestore.collection('users');

  /// Creates a new user profile document at `users/{uid}`.
  Future<void> createUserProfile(UserModel user) async {
    try {
      await _usersRef.doc(user.id).set(user.toJson());
    } catch (e) {
      throw Exception('Failed to create user profile: $e');
    }
  }

  /// Retrieves a user profile by UID. Returns null if not found.
  Future<UserModel?> getUserProfile(String uid) async {
    try {
      final doc = await _usersRef.doc(uid).get();
      if (!doc.exists || doc.data() == null) return null;
      return UserModel.fromJson(doc.data()!);
    } catch (e) {
      throw Exception('Failed to fetch user profile: $e');
    }
  }

  /// Checks whether a user profile exists in Firestore.
  Future<bool> userProfileExists(String uid) async {
    final doc = await _usersRef.doc(uid).get();
    return doc.exists;
  }

  /// Partially updates a user profile document.
  Future<void> updateUserProfile(String uid, Map<String, dynamic> data) async {
    try {
      await _usersRef.doc(uid).update(data);
    } catch (e) {
      throw Exception('Failed to update user profile: $e');
    }
  }
}
