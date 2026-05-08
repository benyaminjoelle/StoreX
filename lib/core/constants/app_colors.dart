import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF2563EB); // Blue
  static const Color accent = Color(0xFF7C3AED); // Purple
  static const Color teal = Color(0xFF14B8A6); // Teal

  // 🌫 Neutral Colors
  static const Color grey = Color(0xFF64748B);

  // 🚨 Semantic Colors
  static const Color error = Color(0xFFEF4444);

  // 🎨 Background Palette
  static const Color backgroundLight = Color(0xFFF1F5F9);
  static const Color backgroundDark = Color(0xFF0F172A);

  static const Color surfaceDark = Color(0xFF1E293B);

  static const Color text = Color(0xFF0F172A);

  static const LinearGradient gradient = LinearGradient(
    colors: [teal, primary, accent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}