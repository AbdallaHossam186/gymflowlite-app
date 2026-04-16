import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymflow_lite/core/theme/app_theme.dart';
import 'package:gymflow_lite/firebase_options.dart';

import 'package:gymflow_lite/routes/app_pages.dart';
import 'package:gymflow_lite/routes/app_routes.dart';

/// Set to 	rue to use Firebase emulators for local development.
/// Set to alse to connect to production Firebase.
const bool useFirebaseEmulators = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (useFirebaseEmulators) {
    await _initFirebaseEmulators();
  } else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // The splash screen is always the entry point. It handles all routing.
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
      debugShowCheckedModeBanner: false,
      title: 'GymFlow Lite',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
    );
  }
}

Future<void> _initFirebaseEmulators() async {
  await Firebase.initializeApp();

  // Connect Auth Emulator
  await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

  // Connect Firestore Emulator
  FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);

  // Connect Storage Emulator
  await FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
}
