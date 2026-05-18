import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class CustomPinTheme {
  /// Returns the complete set of configured PinThemes based on current layout context
  static PinThemeData getThemes(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    // 1. The Default Style
    final defaultTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: theme.textTheme.headlineMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: theme.textTheme.bodyLarge?.color,
      ),
      decoration: BoxDecoration(
        color: isDarkMode 
            ? Colors.white.withOpacity(0.05) 
            : Colors.black.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.transparent),
      ),
    );

    // 2. The Focused Style
    final focusedTheme = defaultTheme.copyWith(
      decoration: defaultTheme.decoration!.copyWith(
        border: Border.all(color: theme.primaryColor, width: 2),
      ),
    );

    // 3. The Error Style
    final errorTheme = defaultTheme.copyWith(
      decoration: BoxDecoration(
        color: theme.colorScheme.error.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.error),
      ),
    );

    return PinThemeData(
      defaultTheme: defaultTheme,
      focusedTheme: focusedTheme,
      errorTheme: errorTheme,
    );
  }
}

/// Simple helper class to return all three configurations at once cleanly
class PinThemeData {
  final PinTheme defaultTheme;
  final PinTheme focusedTheme;
  final PinTheme errorTheme;

  PinThemeData({
    required this.defaultTheme,
    required this.focusedTheme,
    required this.errorTheme,
  });
}