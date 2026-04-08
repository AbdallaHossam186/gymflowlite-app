import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymflow_lite/modules/auth/compnents/gym_chip.dart';

import 'package:gymflow_lite/widgets/rounded_button.dart';

class GymSelectionBottomsheet extends StatefulWidget {
  const GymSelectionBottomsheet({super.key, required this.controller});

  final dynamic controller;

  @override
  State<GymSelectionBottomsheet> createState() =>
      _GymSelectionBottomsheetState();
}

class _GymSelectionBottomsheetState extends State<GymSelectionBottomsheet> {
  // Mock gym data — replace with real data source later
  final List<Map<String, String>> _gyms = const [
    {
      'name': "Gold's Gym Downtown",
      'distance': '0.8 miles away',
      'members': '142 members training',
    },
    {
      'name': 'FitLife 24/7',
      'distance': '1.2 miles away',
      'members': '98 members training',
    },
    {
      'name': 'CrossFit Arena',
      'distance': '2.5 miles away',
      'members': '67 members training',
    },
  ];

  int _selectedIndex = -1;
  String _searchQuery = '';

  List<Map<String, String>> get _filteredGyms {
    if (_searchQuery.isEmpty) return _gyms;
    return _gyms
        .where(
          (g) => g['name']!.toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xffF7F9FC),

      // ── Bottom Button ─────────────────────────────────────────────────
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: RoundedButton(
            onPressed: _selectedIndex >= 0
                ? () {
                    final selectedGym =
                        _filteredGyms[_selectedIndex]['name'] ?? '';
                    // Update the controller

                    widget.controller.selectedGym.value = selectedGym;
                    Get.back();
                  }
                : null,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _selectedIndex >= 0 ? 'Confirm Selection' : 'Select a Gym',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.check_circle, color: Colors.white),
              ],
            ),
          ),
        ),
      ),

      // ── App Bar ────────────────────────────────────────────────────────
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Select Your Gym',
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.close, color: theme.primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      // ── Body Content ───────────────────────────────────────────────────
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Search bar ────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.grey),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                            _selectedIndex = -1; // reset selection on search
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: "Search by name or location...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: theme.primaryColor.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.filter_list,
                        color: theme.primaryColor,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ── Filter Chips ──────────────────────────────────────────────
            SizedBox(
              height: 40,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                children: [
                  _buildFilterChip("Nearby", selected: true),
                  _buildFilterChip("24/7 Access"),
                  _buildFilterChip("Premium"),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ── Gym List ──────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: List.generate(
                  _filteredGyms.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: GymChip(
                      gymName: _filteredGyms[index]['name']!,
                      distance: _filteredGyms[index]['distance']!,
                      membersInfo: _filteredGyms[index]['members']!,
                      isSelected: _selectedIndex == index,
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // ── Purple Card (Can't find your gym?) ───────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: const LinearGradient(
                    colors: [Color(0xff6E4FF6), Color(0xff7A5CFF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Can't find your gym?",
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Suggest a new location and earn rewards.",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 250,
                      child: RoundedButton(
                        onPressed: () {},
                        bgColor: Colors.white,
                        child: Text(
                          "SUGGEST LOCATION",
                          style: TextStyle(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String text, {bool selected = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? Colors.green.shade100 : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: selected ? Colors.green : Colors.grey.shade300,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: selected ? Colors.green.shade700 : Colors.black87,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
