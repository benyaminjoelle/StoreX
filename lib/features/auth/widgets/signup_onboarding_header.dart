import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupOnboardingHeader extends StatelessWidget {
  const SignupOnboardingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textScaler = MediaQuery.textScalerOf(context);

    final titleSize = textScaler.scale(28).clamp(26.0, 44.0);
    final subtitleSize = textScaler.scale(16).clamp(12.0, 22.0);
    final bodySize = textScaler.scale(12).clamp(10.0, 18.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        /// 🔙 Back button
        Align(
          alignment: Alignment.centerLeft,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => Get.back(),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: colors.outline.withOpacity(0.15),
                ),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 18,
                color: colors.onSurface,
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        /// 🧠 Brand
        Text(
          "StoreX",
          style: TextStyle(
            fontFamily: 'Michroma',
            fontSize: titleSize,
            color: colors.primary,
            letterSpacing: 1.5,
          ),
        ),

        const SizedBox(height: 16),


        /// 🌿 Subtitle
        Text(
          "Choose your account type to get started with StoreX".tr,
          style: TextStyle(
            fontSize: bodySize,
            color: colors.onSurface.withOpacity(0.6),
            height: 1.4,
          ),
        ),
      ],
    );
  }
}