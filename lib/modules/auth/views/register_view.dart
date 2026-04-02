import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymflow_lite/modules/auth/compnents/training_discipline_selector.dart';
import 'package:gymflow_lite/modules/auth/controllers/register_controller.dart';
import 'package:gymflow_lite/widgets/gender_selection.dart';
import 'package:gymflow_lite/widgets/labeled_textfield.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  // Design-system colours
  static const Color _primaryColor = Color(0xFF4D41DF);
  static const Color _onSurfaceVariant = Color(0xFF464555);
  static const Color _surfaceContainerLow = Color(0xFFF2F3F7);
  static const Color _outlineVariant = Color(0xFFC7C4D8);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD), // surface
      // ── AppBar ──────────────────────────────────────────────────────────
      appBar: AppBar(
        backgroundColor: Colors.white.withValues(alpha: 0.85),
        elevation: 0,
        shadowColor: Colors.indigo.withValues(alpha: 0.05),
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left_rounded,
            size: 28,
            color: _primaryColor,
          ),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Complete Profile',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: _primaryColor,
            letterSpacing: -0.3,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                'STEP 1 OF 2',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: _onSurfaceVariant,
                  letterSpacing: 1.4,
                ),
              ),
            ),
          ),
        ],
      ),

      // ── Body ────────────────────────────────────────────────────────────
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Avatar ──────────────────────────────────────────────
                Center(
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 112,
                            height: 112,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFFE1E2E6),
                              border: Border.all(color: Colors.white, width: 4),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.12),
                                  blurRadius: 24,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.add_a_photo_rounded,
                              color: Color(0xFF777587),
                              size: 36,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: _primaryColor,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x40675DF9),
                                    blurRadius: 8,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.edit_rounded,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Upload your best self',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Members with photos get 3x more cheers',
                        style: TextStyle(
                          fontSize: 13,
                          color: _onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // ── Full Name ────────────────────────────────────────────
                // _SectionLabel(text: ),
                const SizedBox(height: 8),
                LabeledTextField(
                  prefixIcon: Icons.person_outline_rounded,
                  controller: TextEditingController(),
                  label: 'Your Full Name',
                  hint: 'Alex Rivera',
                ),

                const SizedBox(height: 28),

                // ── Gender ───────────────────────────────────────────────
                GenderSelection(),

                const SizedBox(height: 28),

                // ── Gym Selection ────────────────────────────────────────
                Text(
                  'Primary Gym Hub',
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                _GymSelector(),

                const SizedBox(height: 28),

                // ── Training Discipline ──────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Training Discipline',
                      style: theme.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      'PICK AT LEAST 2',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: _onSurfaceVariant,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TrainingDisciplineGrid(
                  disciplines: controller.disciplines,
                  onToggle: controller.toggle,
                ),

                const SizedBox(height: 32),

                // ── Privacy hint ─────────────────────────────────────────
                _PrivacyHint(),
              ],
            ),
          ),
        ),
      ),

      // ── Sticky Continue Button ───────────────────────────────────────────
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.75),
          boxShadow: [
            BoxShadow(
              color: Colors.indigo.withValues(alpha: 0.06),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: FilledButton.icon(
          onPressed: () {},
          style: FilledButton.styleFrom(
            backgroundColor: _primaryColor,
            minimumSize: const Size.fromHeight(60),
            shape: const StadiumBorder(),
            elevation: 8,
            shadowColor: const Color(0x66675DF9),
          ),
          icon: const Text(
            'Continue',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.2,
            ),
          ),
          label: const Icon(Icons.arrow_forward_rounded, size: 22),
        ),
      ),
    );
  }
}

// ── Helpers ────────────────────────────────────────────────────────────────

// class _SectionLabel extends StatelessWidget {
//   final String text;
//   const _SectionLabel({required this.text});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 4),
//       child: Text(
//         text,
//         style: const TextStyle(
//           fontSize: 14,
//           fontWeight: FontWeight.w600,
//           color: Colors.black87,
//           letterSpacing: 0.1,
//         ),
//       ),
//     );
//   }
// }

// ── Gym Selector ────────────────────────────────────────────────────────────

class _GymSelector extends StatelessWidget {
  static const Color _containerLow = Color(0xFFF2F3F7);
  static const Color _outline = Color(0xFF777587);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Dropdown trigger
        Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: _containerLow,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              const Icon(Icons.stadium_outlined, color: _outline),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Select your local gym...',
                  style: TextStyle(color: _outline, fontSize: 14),
                ),
              ),
              const Icon(Icons.expand_more_rounded, color: _outline),
            ],
          ),
        ),
        const SizedBox(height: 10),
        // Suggestion chips
        Wrap(
          spacing: 8,
          children: [
            _GymChip(label: "Gold's Gym Downtown", isRecent: true),
            _GymChip(label: 'Equinox West', isRecent: false),
          ],
        ),
      ],
    );
  }
}

class _GymChip extends StatelessWidget {
  final String label;
  final bool isRecent;

  const _GymChip({required this.label, required this.isRecent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isRecent
            ? const Color(0xFFEEF2FF) // indigo-50
            : const Color(0xFFE7E8EC), // surface-container-high
        borderRadius: BorderRadius.circular(999),
        border: isRecent
            ? Border.all(color: const Color(0xFFE0E7FF), width: 1)
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isRecent) ...[
            const Icon(
              Icons.history_rounded,
              size: 14,
              color: Color(0xFF4D41DF),
            ),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: isRecent
                  ? const Color(0xFF4D41DF)
                  : const Color(0xFF464555),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Training Discipline Grid ─────────────────────────────────────────────────

class _TrainingDisciplineGrid extends StatefulWidget {
  @override
  State<_TrainingDisciplineGrid> createState() =>
      _TrainingDisciplineGridState();
}

class _TrainingDisciplineGridState extends State<_TrainingDisciplineGrid> {
  static const Color _primaryColor = Color(0xFF4D41DF);
  static const Color _containerHigh = Color(0xFFE7E8EC);
  static const Color _onSurfaceVariant = Color(0xFF464555);

  final List<Map<String, dynamic>> _disciplines = [
    {'label': 'Cardio', 'icon': Icons.bolt_rounded, 'selected': false},
    {
      'label': 'Strength',
      'icon': Icons.fitness_center_rounded,
      'selected': false,
    },
    {
      'label': 'Yoga',
      'icon': Icons.self_improvement_rounded,
      'selected': false,
    },
    {'label': 'CrossFit', 'icon': Icons.timer_rounded, 'selected': false},
    {'label': 'Swimming', 'icon': Icons.pool_rounded, 'selected': false},
    {'label': 'Other', 'icon': Icons.more_horiz_rounded, 'selected': false},
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _disciplines.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2.4,
      ),
      itemBuilder: (context, index) {
        final item = _disciplines[index];
        final isSelected = item['selected'] as bool;

        return GestureDetector(
          onTap: () => setState(() => item['selected'] = !isSelected),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: isSelected ? _primaryColor : _containerHigh,
              borderRadius: BorderRadius.circular(999),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: const Color(0xFF675DF9).withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : [],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item['icon'] as IconData,
                  size: 18,
                  color: isSelected ? Colors.white : _onSurfaceVariant,
                ),
                const SizedBox(width: 6),
                Text(
                  item['label'] as String,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ── Privacy Hint ─────────────────────────────────────────────────────────────

class _PrivacyHint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF2FF).withValues(alpha: 0.6), // indigo-50/50
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 6,
                ),
              ],
            ),
            child: const Icon(
              Icons.verified_rounded,
              color: Color(0xFF4D41DF),
              size: 22,
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Private & Secure',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E1B6B), // indigo-900
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Your data is only used to tailor your personal workout recommendations. You can change this later in settings.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF4338CA), // indigo-800 at 70%
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
