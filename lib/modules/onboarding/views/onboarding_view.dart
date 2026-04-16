import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gymflow_lite/modules/onboarding/controllers/onboarding_controller.dart';
import 'package:gymflow_lite/widgets/rounded_button.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Floating bob widget — wraps any child in a looping up/down animation
// ─────────────────────────────────────────────────────────────────────────────
class _FloatingBob extends StatefulWidget {
  final Widget child;

  /// How many pixels up/down the card travels
  final double amplitude;

  /// Full cycle duration
  final Duration duration;

  /// Phase offset (0.0–1.0) so each card bobs out of sync
  final double phaseOffset;

  const _FloatingBob({
    required this.child,
    this.amplitude = 6.0,
    this.duration = const Duration(milliseconds: 2400),
    this.phaseOffset = 0.0,
  });

  @override
  State<_FloatingBob> createState() => _FloatingBobState();
}

class _FloatingBobState extends State<_FloatingBob>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();

    // Start the animation at the given phase so cards are offset
    _ctrl.value = widget.phaseOffset;

    _anim = Tween<double>(begin: 0, end: 2 * pi).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, child) {
        final dy = sin(_anim.value) * widget.amplitude;
        return Transform.translate(offset: Offset(0, dy), child: child);
      },
      child: widget.child,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Reusable solid floating card (last page)
// ─────────────────────────────────────────────────────────────────────────────
class _FloatingCard extends StatelessWidget {
  final Color avatarColor;
  final IconData icon;
  final String label;
  final String value;

  const _FloatingCard({
    required this.avatarColor,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            backgroundColor: avatarColor,
            radius: 22,
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Reusable glassmorphic pill (pages 0 & 1)
// ─────────────────────────────────────────────────────────────────────────────
class _GlassPill extends StatelessWidget {
  final Widget child;

  const _GlassPill({required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.75),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.4),
              width: 1.5,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Main onboarding view
// ─────────────────────────────────────────────────────────────────────────────
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
                    onPressed: () => controller.finishOnboarding(),
                    child: Text(
                      'SKIP',
                      style: TextStyle(
                        color: Colors.blueGrey.shade400,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Obx(() {
            final isLastPage = controller.pageIndex.value == 2;
            final pageIdx = controller.pageIndex.value;

            // ── Standard hero image (pages 0 & 1) ──────────────────────────
            final heroStack = AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              height: pageIdx == 0 ? 520 : 280,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.black87,
                image: DecorationImage(
                  image: NetworkImage(
                    controller.onboardingPages[pageIdx].imagePath,
                  ),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  // ── Bottom glass pill ──────────────────────────────────
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: _FloatingBob(
                      amplitude: 5,
                      duration: const Duration(milliseconds: 2600),
                      phaseOffset: 0.0,
                      child: _GlassPill(
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: const Color(0xFF6CF0B8),
                              radius: 20,
                              child: Icon(
                                pageIdx == 1
                                    ? Icons.calendar_today
                                    : Icons.person,
                                color: Colors.black87,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  pageIdx == 1 ? 'AVAILABILITY' : 'Sarah J.',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.2,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  pageIdx == 1
                                      ? '6:00 AM – 8:00 AM'
                                      : '"Looking for a squat partner!"',
                                  style: const TextStyle(
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

                  // ── Top glass pill ─────────────────────────────────────
                  Positioned(
                    top: 20,
                    left: 100,
                    right: 20,
                    child: _FloatingBob(
                      amplitude: 5,
                      duration: const Duration(milliseconds: 2200),
                      phaseOffset: 0.5, // half-cycle out of sync
                      child: _GlassPill(
                        child: Row(
                          children: [
                            Container(
                              height: 10,
                              width: 10,
                              decoration: const BoxDecoration(
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
                ],
              ),
            );

            // ── Last page hero: image + overflowing animated cards ──────────
            final lastPageHero = SizedBox(
              height: 340,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Main image
                  Positioned(
                    left: 32,
                    right: 0,
                    top: 44,
                    bottom: 44,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        color: Colors.black87,
                        image: DecorationImage(
                          image: NetworkImage(
                            controller.onboardingPages[pageIdx].imagePath,
                          ),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 24,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // NEW RECORD card — top-left, bobs slowly
                  Positioned(
                    top: 0,
                    left: 0,
                    child: _FloatingBob(
                      amplitude: 6,
                      duration: const Duration(milliseconds: 2800),
                      phaseOffset: 0.0,
                      child: const _FloatingCard(
                        avatarColor: Color(0xFF4CD9A0),
                        icon: Icons.trending_up_rounded,
                        label: 'NEW RECORD',
                        value: '120kg Squat',
                      ),
                    ),
                  ),

                  // TOTAL VOLUME card — bottom-right, bobs offset
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: _FloatingBob(
                      amplitude: 6,
                      duration: const Duration(milliseconds: 2400),
                      phaseOffset: 0.5, // opposite phase
                      child: const _FloatingCard(
                        avatarColor: Color(0xFF5B5BD6),
                        icon: Icons.fitness_center_rounded,
                        label: 'TOTAL VOLUME',
                        value: '12,450 lbs',
                      ),
                    ),
                  ),
                ],
              ),
            );

            // ── Title + Subtitle ────────────────────────────────────────────
            final textSection = Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                controller.onboardingPages[pageIdx].firstSectionTitle != null
                    ? Text.rich(
                        TextSpan(
                          text: controller
                              .onboardingPages[pageIdx]
                              .firstSectionTitle,
                          style: theme.textTheme.headlineLarge!.copyWith(
                            fontWeight: FontWeight.w900,
                            fontSize: 32,
                          ),
                          children: [
                            TextSpan(
                              text: controller
                                  .onboardingPages[pageIdx]
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
                        controller.onboardingPages[pageIdx].title ?? '',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineLarge!.copyWith(
                          fontWeight: FontWeight.w900,
                          fontSize: 32,
                        ),
                      ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    controller.onboardingPages[pageIdx].description,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: Colors.blueGrey.shade600,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            );

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),

                // ── Animated swap ───────────────────────────────────────────
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 450),
                  switchInCurve: Curves.easeOutCubic,
                  switchOutCurve: Curves.easeInCubic,
                  transitionBuilder: (child, animation) {
                    final slide = Tween<Offset>(
                      begin: const Offset(0, 0.12),
                      end: Offset.zero,
                    ).animate(animation);
                    return SlideTransition(
                      position: slide,
                      child: FadeTransition(opacity: animation, child: child),
                    );
                  },
                  child: Column(
                    key: ValueKey(isLastPage),
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: isLastPage
                        ? [
                            textSection,
                            const SizedBox(height: 24),
                            lastPageHero,
                          ]
                        : [heroStack, textSection],
                  ),
                ),

                const Spacer(),

                // ── Time Selection Cards (page 1 only) ──────────────────────
                pageIdx == 1
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
                                    color: theme.primaryColor.withValues(
                                      alpha: 0.3,
                                    ),
                                    blurRadius: 15,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Column(
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

                // ── Back + Next / Get Started ───────────────────────────────
                Row(
                  children: [
                    AnimatedOpacity(
                      opacity: pageIdx > 0 ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      child: pageIdx > 0
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
                    Expanded(
                      child: AnimatedAlign(
                        alignment: Alignment.centerRight,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: SizedBox(
                          width: pageIdx > 0
                              ? MediaQuery.of(context).size.width * 0.62
                              : double.infinity,
                          height: 56,
                          child: RoundedButton(
                            onPressed: () {
                              if (controller.pageIndex.value < 2) {
                                controller.pageIndex.value++;
                              } else {
                                controller.finishOnboarding();
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  isLastPage ? 'Get Started' : 'Next',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(Icons.arrow_forward, size: 24),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // ── Step Indicator ──────────────────────────────────────────
                Obx(
                  () => Text(
                    'STEP ${controller.pageIndex.value + 1} OF 3 • ${controller.onboardingPages[controller.pageIndex.value].stepName}',
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
            );
          }),
        ),
      ),
    );
  }
}
