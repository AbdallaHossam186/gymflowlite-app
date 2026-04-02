import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymflow_lite/modules/auth/data/models/discipline_model.dart';

class TrainingDisciplineGrid extends StatelessWidget {
  final RxList<DisciplineItem> disciplines;
  final void Function(int index) onToggle;

  static const Color _primaryColor = Color(0xFF4D41DF);
  static const Color _containerHigh = Color(0xFFE7E8EC);
  static const Color _onSurfaceVariant = Color(0xFF464555);

  const TrainingDisciplineGrid({
    super.key,
    required this.disciplines,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    // Lazily put if not already registered

    return Obx(
      () => GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: disciplines.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 2.4,
        ),
        itemBuilder: (context, index) {
          final item = disciplines[index];

          return GestureDetector(
            onTap: () => onToggle(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: item.selected ? _primaryColor : _containerHigh,
                borderRadius: BorderRadius.circular(999),
                boxShadow: item.selected
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
                    item.icon,
                    size: 18,
                    color: item.selected ? Colors.white : _onSurfaceVariant,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    item.label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: item.selected ? Colors.white : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
