import 'package:flutter/material.dart';

class DisciplineItem {
  final String label;
  final IconData icon;
  bool selected;

  DisciplineItem({
    required this.label,
    required this.icon,
    this.selected = false,
  });
}
