import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final loginFormKey = GlobalKey<FormState>();
  // Text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // UI state
  final isPasswordHidden = true.obs;

  void login() {
    // This triggers all validators in the form
    if (loginFormKey.currentState!.validate()) {
      Get.toNamed('/clientRoot');
    } else {
      print("Form is invalid!");
    }
  }

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
