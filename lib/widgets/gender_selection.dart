import 'package:flutter/material.dart';

class GenderSelection extends StatefulWidget {
  final String? initialValue;
  final ValueChanged<String>? onChanged;

  const GenderSelection({super.key, this.initialValue, this.onChanged});

  @override
  State<GenderSelection> createState() => _GenderSelectionState();
}

class _GenderSelectionState extends State<GenderSelection> {
  late String _selected;

  final List<String> _options = ['Male', 'Female', 'Other'];

  @override
  void initState() {
    super.initState();
    _selected = widget.initialValue ?? 'Male';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Label ─────────────────────────────────────────────────────────
        const Text(
          'Gender Identification',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),

        const SizedBox(height: 10),

        // ── Pill toggle ────────────────────────────────────────────────────
        Container(
          height: 60,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _options.map((option) {
              final isSelected = _selected == option;
              return GestureDetector(
                onTap: () {
                  setState(() => _selected = option);
                  widget.onChanged?.call(option);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeInOut,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(60),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : [],
                  ),
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 220),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                      color: isSelected
                          ? const Color(0xFF5B5BD6)
                          : Colors.grey.shade500,
                    ),
                    child: Text(option),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
