import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gymflow_lite/modules/onboarding/controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 100,
        centerTitle: controller.pageIndex.value == 2 ? true : false,
        title: Obx(
          () => Row(
            mainAxisAlignment: controller.pageIndex.value == 2
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: List.generate(3, (i) {
              final active = controller.pageIndex.value == i;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: active ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: active ? theme.primaryColor : Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
        ),
        actions: [
          Obx(
            () => controller.pageIndex.value != 2
                ? TextButton(
                    onPressed: () {
                      controller.pageIndex.value = 2; // Jump to last page
                    },
                    child: Text(
                      'SKIP',
                      style: TextStyle(
                        color: Colors.blueGrey.shade400,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),

                // --- Main Hero Image & Overlay ---
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  height: controller.pageIndex.value == 0 ? 520 : 280,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.black87,
                    image: DecorationImage(
                      image: NetworkImage(
                        controller
                            .onboardingPages[controller.pageIndex.value]
                            .imagePath,
                      ), // Replace with your hero image
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      // Glassmorphic floating overlay
                      Positioned(
                        bottom: 20,
                        left: 20,
                        right: 20,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 10.0,
                              sigmaY: 10.0,
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.75),
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.4),
                                  width: 1.5,
                                ),
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: const Color(0xFF6CF0B8),
                                    radius: 20,
                                    child: Icon(
                                      controller.pageIndex.value == 1
                                          ? Icons.calendar_today
                                          : controller.pageIndex.value == 2
                                          ? Icons.line_weight
                                          : Icons.person,
                                      color: Colors.black87,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        controller.pageIndex.value == 1
                                            ? 'AVAILABILITY'
                                            : controller.pageIndex.value == 2
                                            ? 'TOTAL VOLUME'
                                            : 'Sarah J.',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 1.2,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        controller.pageIndex.value == 1
                                            ? '6:00 AM – 8:00 AM'
                                            : controller.pageIndex.value == 2
                                            ? '12,450 lbs'
                                            : '"Looking for a squat partner!"',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: 20,
                        left: 100,
                        right: 20,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 10.0,
                              sigmaY: 10.0,
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.75),
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.4),
                                  width: 1.5,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Text(
                                    '12 PEOPLE TRAINING NOW',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // --- Title ---
                controller
                            .onboardingPages[controller.pageIndex.value]
                            .firstSectionTitle !=
                        null
                    ? Text.rich(
                        TextSpan(
                          text: controller
                              .onboardingPages[controller.pageIndex.value]
                              .firstSectionTitle,
                          style: theme.textTheme.headlineLarge!.copyWith(
                            fontWeight: FontWeight.w900,

                            fontSize: 32,
                          ),
                          children: [
                            TextSpan(
                              text: controller
                                  .onboardingPages[controller.pageIndex.value]
                                  .secondSectionTitle,
                              style: theme.textTheme.headlineLarge!.copyWith(
                                color: theme.primaryColor,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.italic,
                                fontSize: 32,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      )
                    : Text(
                        controller
                                .onboardingPages[controller.pageIndex.value]
                                .title ??
                            '',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineLarge!.copyWith(
                          fontWeight: FontWeight.w900,
                          fontSize: 32,
                        ),
                      ),

                const SizedBox(height: 12),

                // --- Subtitle ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    controller
                        .onboardingPages[controller.pageIndex.value]
                        .description,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: Colors.blueGrey.shade600,
                      height: 1.4,
                    ),
                  ),
                ),

                const Spacer(),

                // --- Time Selection Cards (Merged from Screen 2) ---
                controller.pageIndex.value == 1
                    ? Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.wb_twilight,
                                      color: theme.primaryColor,
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'MORNING',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              decoration: BoxDecoration(
                                color: theme.primaryColor,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: theme.primaryColor.withOpacity(0.3),
                                    blurRadius: 15,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.wb_sunny, color: Colors.white),
                                    SizedBox(height: 8),
                                    Text(
                                      'AFTERNOON',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),

                const Spacer(),

                // --- Next Button ---
                // --- Back + Next Button Row ---
                Row(
                  children: [
                    // Back button (text style, fades in on page 2+)
                    AnimatedOpacity(
                      opacity: controller.pageIndex.value > 0 ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      child: controller.pageIndex.value > 0
                          ? TextButton(
                              onPressed: () {
                                if (controller.pageIndex.value > 0) {
                                  controller.pageIndex.value--;
                                }
                              },
                              child: Text(
                                'BACK',
                                style: TextStyle(
                                  color: Colors.blueGrey.shade400,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),

                    // Next button (shrinks from left as back button appears)
                    Expanded(
                      child: AnimatedAlign(
                        alignment: Alignment.centerRight,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: SizedBox(
                          width: controller.pageIndex.value > 0
                              ? MediaQuery.of(context).size.width * 0.62
                              : double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.primaryColor,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () {
                              if (controller.pageIndex.value < 2) {
                                controller.pageIndex.value++;
                              } else {
                                // Handle last page
                              }
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Next',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(Icons.arrow_forward, size: 24),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // --- Step Indicator ---
                Obx(
                  () => Text(
                    'STEP ${controller.pageIndex.value + 1} OF 3 • SCHEDULING',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
