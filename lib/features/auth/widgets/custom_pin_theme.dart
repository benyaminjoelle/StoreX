import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class CustomPinTheme extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onCompleted;
  final String? Function(String?)? validator;
  final int length;
  final TextInputType keyboardType;

  const CustomPinTheme({
    super.key,
    this.controller,
    this.onCompleted,
    this.validator,
    this.length = 4,
    this.keyboardType = TextInputType.number,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = getThemes(context);

    return Pinput(
      length: length,
      controller: controller,
      defaultPinTheme: themeData.defaultTheme,
      focusedPinTheme: themeData.focusedTheme,
      errorPinTheme: themeData.errorTheme,
      keyboardType: keyboardType,
      validator: validator,
      onCompleted: onCompleted,
    );
  }

  static PinThemeData getThemes(BuildContext context) {
    final theme = Theme.of(context);

    // 1. The Default Style
    final defaultTheme = PinTheme(
      width: 50,
      height: 56,
      textStyle: theme.textTheme.headlineMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: theme.textTheme.bodyLarge?.color,
      ),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.primaryColor),
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