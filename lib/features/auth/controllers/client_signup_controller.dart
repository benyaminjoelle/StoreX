import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storex/core/constants/app_colors.dart';


import 'package:storex/features/auth/models/auth_repo.dart';
import 'package:storex/widgets/app_dialog.dart';
import 'package:storex/widgets/app_snackbar.dart';

class ClientSignupController extends GetxController {
  /// =========================================================
  /// REPO
  /// =========================================================
  final AuthRepo _authRepo = AuthRepo();

  /// =========================================================
  /// FORM KEY
  /// =========================================================
  final clientSignupKey = GlobalKey<FormState>();

  /// =========================================================
  /// CONTROLLERS
  /// =========================================================
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final businessNameController = TextEditingController();

  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
 
  final otpController = TextEditingController();

  /// =========================================================
  /// OBSERVABLES
  /// =========================================================
  final isPasswordHidden = true.obs;
  final isConfirmPasswordHidden = true.obs;
  final isLoading = false.obs;

  ThemeData get theme => Get.theme;

  /// =========================================================
  /// VALIDATION
  /// =========================================================
  bool validateClient() {
    return clientSignupKey.currentState?.validate() ?? false;
  }

  /// =========================================================
  /// PASSWORD TOGGLE
  /// =========================================================
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value =
        !isConfirmPasswordHidden.value;
  }

  /// =========================================================
  /// SIGNUP FLOW (REAL)
  /// =========================================================
 
  Future<void> continueToVerify() async {
    if (!validateClient()) {
      AppSnackbar.show(
        title: "Invalid Data".tr,
        message: "Please check your inputs".tr,
        icon: Icons.warning_amber_rounded,
        iconColor: AppColors.error,
      );
      return;
    }

    try {
      isLoading.value = true;

      final userData = {
        'first_name': firstNameController.text.trim(),
        'last_name': lastNameController.text.trim(),
        'email': emailController.text.trim(),
        'phone_number': phoneController.text.trim(),
        'business_name':businessNameController.text.trim(),
        'password': passwordController.text,
        /// IMPORTANT
        'role': 'client',
      };

      print("════════ REGISTER OWNER ════════");
      print("📤 Sending:");
      print(userData);

      final user = await _authRepo.clientRegister(
        userData,
      );

      print("✅ Registration Success");
      print("🆔 User ID: ${user.id}");
      print("📧 Email: ${user.email}");
      print("🎭 Role: ${user.role}");

      AppSnackbar.show(
        title: "Success".tr,
        message: "Account created successfully".tr,
        icon: Icons.check_circle_outline,
        iconColor: Colors.green,
      );

      Get.toNamed(
        '/verifyCode',
        arguments: {
          'email': user.email,
          'password':user.password
        },
      );
    } catch (e) {
      print("❌ Registration Error: $e");

      AppSnackbar.show(
        title: "Error".tr,
        message: e.toString(),
        icon: Icons.error_outline,
        iconColor: AppColors.error,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// =========================================================
  /// BACK BUTTON
  /// =========================================================
  Future<void> handleBack() async {
    final result = await AppDialogs.showConfirmDialog(
      title: "Exit signup?".tr,
      message:
          "Your progress will be lost if you leave now.".tr,
      confirmText: "Exit",
      confirmColor: theme.colorScheme.error,
    );

    if (result == true) {
      Get.back();
    }
  }

  /// =========================================================
  /// DISPOSE
  /// =========================================================
  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
   
    otpController.dispose();

    super.onClose();
  }
}