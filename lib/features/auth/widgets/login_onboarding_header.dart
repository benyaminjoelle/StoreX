import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginOnboardingHeader extends StatelessWidget {
  const LoginOnboardingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         IconButton(
                onPressed: () => Get.back(),
                icon: Icon(Icons.arrow_back_ios_new, color: colors.primary),
              ),

              const SizedBox(height: 10),
        Text(
          "StoreX",
          style: const TextStyle(
            fontFamily: 'Michroma',
            fontSize: 28,
            letterSpacing: 1.2,
          ).copyWith(color: colors.primary),
        ),

        const SizedBox(height: 6),

        Text(
          "Welcome to your control center",
          style: theme.textTheme.titleMedium,
        ),

        const SizedBox(height: 6),

        Text(
          "Select your role to continue",
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colors.onSurface.withOpacity(0.6),
          ),
        ),
      ],
    );
  }
}