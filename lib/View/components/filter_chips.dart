import 'package:flutter/material.dart';
import '../styles.dart';

class FilterChips extends StatelessWidget {
  final List<String> filters;
  final List<String> activeFilters;
  final void Function(String) onToggle;

  const FilterChips({super.key, required this.filters, required this.activeFilters, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: 8, children: filters.map((f) {
      final selected = activeFilters.contains(f);
      return GestureDetector(
        onTap: () => onToggle(f),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: selected ? AppColors.primary : Colors.transparent)),
          child: Text(f, style: TextStyle(color: AppColors.dark)),
        ),
      );
    }).toList());
  }
}
