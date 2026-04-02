import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymflow_lite/modules/auth/data/models/discipline_model.dart';

class RegisterController extends GetxController {
  final disciplines = <DisciplineItem>[
    DisciplineItem(label: 'Cardio', icon: Icons.bolt_rounded),
    DisciplineItem(label: 'Strength', icon: Icons.fitness_center_rounded),
    DisciplineItem(label: 'Yoga', icon: Icons.self_improvement_rounded),
    DisciplineItem(label: 'CrossFit', icon: Icons.timer_rounded),
    DisciplineItem(label: 'Swimming', icon: Icons.pool_rounded),
    DisciplineItem(label: 'Other', icon: Icons.more_horiz_rounded),
  ].obs;

  void toggle(int index) {
    disciplines[index].selected = !disciplines[index].selected;
    disciplines.refresh(); // notify listeners
  }

  List<String> get selectedLabels =>
      disciplines.where((d) => d.selected).map((d) => d.label).toList();
}
