import 'package:flutter/material.dart';

/// Centralized UI colors (not domain concepts).
///
/// Keep these stable and map them into `ThemeData` via `AppTheme`.
class AppColors {
  const AppColors._();

  // Brand / semantic
  static const Color primary = Color(0xFF2E6CF6);
  static const Color secondary = Color(0xFF00A884);

  // Surface / text
  static const Color surface = Color(0xFFF8FAFC);
  static const Color onSurface = Color(0xFF0F172A);

  // Semantic statuses (non-ColorScheme)
  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFDC2626);
  static const Color info = Color(0xFF2563EB);
}

