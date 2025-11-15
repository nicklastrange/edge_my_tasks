import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF1B4E9B);
  static const Color accent = Color(0xFFF0A020);
  static const Color dark = Color(0xFF0D1F3A);
  static const Color background = Color(0xFFF2F2F2);
}

const double kCardRadius = 16.0;
const double kPagePadding = 20.0;

BoxDecoration cardDecoration() => BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(kCardRadius),
      // use Color.fromRGBO to avoid deprecated withOpacity
      boxShadow: [BoxShadow(color: const Color.fromRGBO(0, 0, 0, 0.03), blurRadius: 8, offset: const Offset(0, 3))],
    );

ButtonStyle primaryButtonStyle() => ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      minimumSize: const Size.fromHeight(54),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    );

// Typography tokens
const TextStyle kH1 = TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.dark, decoration: TextDecoration.none);
const TextStyle kH2 = TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.dark, decoration: TextDecoration.none);
const TextStyle kSubtitle = TextStyle(fontSize: 14, color: Colors.grey, decoration: TextDecoration.none);
const TextStyle kMetricTitle = TextStyle(fontSize: 14, color: AppColors.dark, decoration: TextDecoration.none);
const TextStyle kMetricValue = TextStyle(fontSize: 22, fontWeight: FontWeight.bold, decoration: TextDecoration.none);
