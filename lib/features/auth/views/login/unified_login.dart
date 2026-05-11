import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storex/core/utils/validators.dart';
import 'package:storex/features/auth/widgets/login_onboarding_header.dart';

class UnifiedLogin extends StatelessWidget {
  const UnifiedLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    
    // Choose the image path based on the theme
    final String backgroundImage = isDarkMode 
        ? 'assets/images/bg_dark.png'  // Your dark theme image
        : 'assets/images/bg_light.png'; // Your light theme image

    final media = MediaQuery.of(context);
    final textScale = media.textScaler.clamp(
      minScaleFactor: 0.8,
      maxScaleFactor: 1.3,
    );

    return Scaffold(
      body: Stack(
        children: [
          // 1. Background Image Layer
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundImage),
                fit: BoxFit.cover, // Ensures the photo covers the entire screen
                // Optional: Add a slight overlay if the image makes text hard to read
                colorFilter: ColorFilter.mode(
                  theme.colorScheme.surface.withValues(alpha: 0.1),
                  BlendMode.darken,
                ),
              ),
            ),
          ),

          // 2. Content Layer
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const LoginOnboardingHeader(),
                  const SizedBox(height: 8),
                 
                  const Spacer(flex: 1), 
                  Center(
                    child:
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}