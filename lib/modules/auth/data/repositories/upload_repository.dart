import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class UploadRepository {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Uploads a profile picture to Firebase Storage and returns the download URL.
  ///
  /// Stores at: `profile_pictures/{userId}/profile_pic.jpg`
  Future<String?> uploadProfilePicture(File file, String userId) async {
    try {
      debugPrint('[UploadRepo] Starting upload for user: $userId');
      debugPrint('[UploadRepo] File path: ${file.path}');
      debugPrint('[UploadRepo] File exists: ${await file.exists()}');

      final ref = _storage
          .ref()
          .child('profile_pictures/$userId/profile_pic.jpg');

      // Set proper metadata so Storage knows it's an image
      final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'uploadedBy': userId},
      );

      final uploadTask = ref.putFile(file, metadata);

      // Monitor progress
      uploadTask.snapshotEvents.listen((snapshot) {
        final progress =
            snapshot.bytesTransferred / snapshot.totalBytes * 100;
        debugPrint('[UploadRepo] Upload progress: ${progress.toStringAsFixed(1)}%');
      });

      // Wait for upload to complete
      final snapshot = await uploadTask;
      debugPrint('[UploadRepo] Upload complete. State: ${snapshot.state}');

      // Get the download URL
      final downloadUrl = await ref.getDownloadURL();
      debugPrint('[UploadRepo] Download URL: $downloadUrl');

      return downloadUrl;
    } on FirebaseException catch (e) {
      debugPrint('[UploadRepo] FirebaseException: ${e.code} - ${e.message}');
      throw Exception('Failed to upload profile picture: ${e.message}');
    } catch (e) {
      debugPrint('[UploadRepo] Unexpected error: $e');
      throw Exception('Failed to upload profile picture: $e');
    }
  }
}
