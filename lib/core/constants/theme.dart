import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  // 🌞 LIGHT: Modern Slate Grey (No pure white)
  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Tajawal',
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    primaryColor: AppColors.primary,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.accent,
      tertiary: AppColors.teal,
      surface: Colors.white,
      error: AppColors.error,
       // Keep surfaces white so they "pop" off the slate background
      onSurface: AppColors.text,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundLight,
      foregroundColor: AppColors.text,
      elevation: 0,
    ),
  );

  // 🌙 DARK: Deep Midnight Navy
  static ThemeData darkTheme = ThemeData(
    fontFamily: 'Tajawal',
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    primaryColor: AppColors.primary,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.accent,
      tertiary: AppColors.teal,
      surface: AppColors.surfaceDark, // Cards look better slightly lighter than the BG
      onSurface: Colors.white,
      error: AppColors.error
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundDark,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
  
  );

 
}