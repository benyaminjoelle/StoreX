import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isDisabled;

  const SecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final effectiveOnPressed =
        isDisabled ? null : onPressed;

    return SizedBox(
      width: double.infinity,
      height: 54,
      child: OutlinedButton(
        onPressed: effectiveOnPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: isDisabled
                ? colors.outlineVariant
                : colors.primary,
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          text,
          style: theme.textTheme.titleMedium?.copyWith(
            color: isDisabled
                ? colors.onSurfaceVariant
                : colors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}