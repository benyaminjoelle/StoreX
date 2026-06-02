import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storex/features/auth/controllers/forgot_pass_controller.dart';
import 'package:storex/widgets/primary_button.dart';
import 'package:storex/widgets/app_snackbar.dart';

class EmailBottomSheet {
  final controller = Get.find<ForgotPassController>();
  // 1. Made this a static method so it can be called easily
  static void show(BuildContext context, ForgotPassController controller, ThemeData theme) {
    controller.emailController.text = controller.email.value;

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20, 
        ),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Text(
                "Change Email Address".tr,
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                "We will send a new verification code to this email address.".tr,
                style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "New Email Address".tr,
                  hintText: "Enter your email".tr,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(height: 25),
              PrimaryButton(
                text: "Update & Resend Code".tr,
                onPressed: () {
                  String inputEmail = controller.emailController.text.trim();
                  
                  if (inputEmail.isEmpty || !GetUtils.isEmail(inputEmail)) {
                    AppSnackbar.show(
                      title: "Invalid Email".tr,
                      message: "Please enter a valid email address".tr,
                      icon: Icons.warning_amber_rounded,
                    );
                    return;
                  }
                  
                  controller.updateEmailAndResend(inputEmail);
                  Get.back(); 
                  
                  AppSnackbar.show(
                    title: "Email Updated".tr,
                    message: "A new code has been sent successfully!".tr,
                    icon: Icons.check_circle_outline,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true, 
    );
  }
}