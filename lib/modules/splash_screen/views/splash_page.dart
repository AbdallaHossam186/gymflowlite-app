import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymflow_lite/modules/splash_screen/controllers/splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/textures.jpg'),
            repeat: ImageRepeat.repeat,
            colorFilter: ColorFilter.mode(
              Theme.of(context).primaryColor.withValues(alpha: 0.8),
              BlendMode.srcATop,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const Spacer(flex: 4),

            // --- Center icon ---
            Image.asset(
              'assets/images/logo.png',
              width: 250,
              height: 250,
              fit: BoxFit.cover,
            ),

            // --- GymFlow Lite Text ---
            Text.rich(
              TextSpan(
                text: 'GymFlow',
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontSize: 48,
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: ' Lite',
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 48,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            // --- Underline ---
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            const Spacer(flex: 4),

            // --- Find your training partner ---
            Text(
              'FIND YOUR TRAINING PARTNER',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
                letterSpacing: 1.5,
              ),
            ),

            const SizedBox(height: 24),

            // --- Progress Bar ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 128),
              child: LinearProgressIndicator(
                borderRadius: BorderRadius.circular(8),
                backgroundColor: Colors.white.withValues(alpha: 0.1),
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // --- Version text ---
            Text(
              'VERSION 1.0.0  •  ABDALLA HOSSAM',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 64),
          ],
        ),
      ),
    );
  }
}
