import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storex/core/utils/validators.dart';
import 'package:storex/features/auth/controllers/login_controller.dart';
import 'package:storex/features/auth/widgets/login_onboarding_header.dart';
import 'package:storex/widgets/custom_textfield.dart';
import 'package:storex/widgets/primary_button.dart';

class UnifiedLogin extends StatelessWidget {
  const UnifiedLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
     final controller = Get.find<LoginController>();
    
    // Choose the image path based on the theme
    final String backgroundImage = isDarkMode 
        ? 'assets/photos/login_dark.png'  // Your dark theme image
        : 'assets/photos/login_light.png'; // Your light theme image

    final media = MediaQuery.of(context);
    final textScale = media.textScaler.clamp(
      minScaleFactor: 0.8,
      maxScaleFactor: 1.3,
    );

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // Dismiss keyboard on tap outside
      child: Scaffold(
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
                    theme.colorScheme.surface.withValues(alpha: 0.2),
                    BlendMode.darken,
                  ),
                ),
              ),
            ),
      
      
      // 2. Content Layer
      SafeArea(

        child: Center( // Center the card on the screen
      child: SingleChildScrollView( // 1. Allows scrolling when keyboard appears
      physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 70), 
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3), // 2. Blurs the background behind the card
            child: Container(
              // margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
              decoration: BoxDecoration(
                
                color: theme.colorScheme.surface.withValues(alpha: 0.3), // Increased opacity for readability
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.15),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // 2. Important: Tells Column to only take needed space
                children: [
                  const SizedBox(height: 5),
                  const LoginOnboardingHeader(),
                  SizedBox(height: media.size.height * 0.08), // Fixed spacing instead of Spacer
                  
                  
                  CustomTextField(
                    controller: controller.emailController,
                    label: 'Email Address/Phone number'.tr,
                    hint: 'Enter Email or Phone number'.tr,
                  //  prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => Validators.emailValidation(value),
                  ),
                  
                   SizedBox(height: media.size.height * 0.03),
                  
                 Obx(
  () => CustomTextField(
    controller: controller.passwordController,
    label: 'Password'.tr,
    hint: 'Enter your password'.tr,
    isPassword: true,
    isObscure: controller.isPasswordHidden.value,
    onToggleVisibility: controller.togglePasswordVisibility,
    textInputAction: TextInputAction.done,
    validator: (value) => Validators.passwordValidation(value),
    suffix: TextButton(
      onPressed: () {},
      child: Text('Forgot Password?'.tr),
    ),
  ),
),
                  SizedBox(height: media.size.height * 0.1), 
                  
                  PrimaryButton(text: "Login".tr, onPressed: () {
                    // Handle login logic
                  }),
                ],
              ),
            ),
          ),
                ),
        ),
        ),
      ),
      ),
      // 3. Premium Back Button
            Positioned(
              top: media.padding.top + 10,
              left: 20,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
                      ),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: theme.colorScheme.onSurface,
                        size: 20,
                      ),
                      onPressed: () => Get.back(), // Using GetX for navigation
                    ),
                ),
               ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}