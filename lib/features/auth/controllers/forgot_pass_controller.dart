import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ForgotPassController extends GetxController{
  //------------TextField Controllers-----------------
  final emailController = TextEditingController();
  final codeController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final passwordKey = GlobalKey<FormState>();


  //------------states -----------------
  var isLoading = false.obs;
  
  // --- Step 1: Send Email API ---
  Future<void> sendVerificationEmail() async {
    try {
      isLoading.value = true;
      // Your API logic here using emailController.text
      
      // On success, move to the OTP Screen
      Get.toNamed('/verifyCode');
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // --- Step 2: Verify OTP API ---
  Future<void> verifyCode() async {
    try {
      isLoading.value = true;
      // Your API logic here using otpController.text
      
      // On success, move to Reset Password Screen
      Get.toNamed('/resetPassword');
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // --- Step 3: Reset Password API ---
  Future<void> updatePassword() async {
    try {
      isLoading.value = true;
      // Your API logic here using newPasswordController.text
      
      // Flow finished! Clear data and go back to Login Screen
      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    codeController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}