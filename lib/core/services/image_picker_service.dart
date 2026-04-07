import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 75,
      );
      return _persistFile(image);
    } catch (e) {
      debugPrint('Error picking image: $e');
      return null;
    }
  }

  Future<File?> pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 75,
      );
      return _persistFile(image);
    } catch (e) {
      debugPrint('Error picking image: $e');
      return null;
    }
  }

  /// Copies the picked temp file to a stable location so it survives
  /// until upload time (image_picker cache files can be purged by the OS).
  Future<File?> _persistFile(XFile? xFile) async {
    if (xFile == null) {
      debugPrint('No image selected.');
      return null;
    }

    final tempFile = File(xFile.path);

    // Copy to the same directory but with a stable name
    final dir = tempFile.parent.path;
    final stablePath = p.join(dir, 'gymflow_profile_pic.jpg');
    final stableFile = await tempFile.copy(stablePath);

    debugPrint('[ImagePicker] Persisted image to: ${stableFile.path}');
    debugPrint('[ImagePicker] File exists: ${stableFile.existsSync()}');
    debugPrint('[ImagePicker] File size: ${await stableFile.length()} bytes');

    return stableFile;
  }
}
