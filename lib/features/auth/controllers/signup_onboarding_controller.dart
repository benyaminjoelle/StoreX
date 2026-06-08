import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storex/core/constants/app_colors.dart';
import 'package:storex/core/utils/pref_helper.dart';
import 'package:storex/features/auth/models/auth_repo.dart';
import 'package:storex/features/auth/models/user_model.dart';
import 'package:storex/widgets/app_snackbar.dart';

class SignupOnboardingController extends GetxController {

  final AuthRepo _authRepo = AuthRepo();

  final Rxn<UserRole> selectedType = Rxn<UserRole>();
  final emailController = TextEditingController();
  var password = '';
  var email = "user@example.com".obs;
  final formKey = GlobalKey<FormState>();

  ThemeData get theme => Get.theme;

  void selectRole(UserRole type) {
    selectedType.value = type;
  }
  void clearSelection() {
    selectedType.value = null;
  }

  bool isSelected(UserRole type) {
    return selectedType.value == type;
  }

  void continueSignup() {
    final selected = selectedType.value;
if (selected == null) {
  AppSnackbar.show(
    title: "Selection Required".tr,
    message: "Please choose an account type".tr,
    icon: Icons.warning_amber_rounded,
    iconColor:AppColors.error
  );
  return;
}

    switch (selected) {
      case UserRole.client:
        Get.toNamed('/clientSignup');
        break;

      case UserRole.warehouseAdmin:
        Get.toNamed('/ownerSignup');
        break;

      case UserRole.worker:
       Get.toNamed('/workerSignup');
        break;
    }
  }

    Timer? timer;
  var secondsRemaining = 60.obs;
  var isResendEnabled = true.obs;

  @override
void onInit() {
  super.onInit();

  print("════════ VERIFY SCREEN ARGS ════════");
  print(Get.arguments);

  final args = Get.arguments;

  if (args != null) {
    email.value = args['email'] ?? '';
    password = args['password'] ?? '';
  }

  print("EMAIL = $email");
  print("PASSWORD = $password");

  startResendTimer();
}

  void startResendTimer() {
    isResendEnabled.value = false;
    secondsRemaining.value += 10; //reset for 60 after testing
    //cancel any timers if already running
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        isResendEnabled.value = true;
        timer.cancel();
      }
    });
  }
Future<void> changeEmail(String newEmail) async {
  try {
    isLoading.value = true;

    final userId = await PrefHelper.getUserId();

    if (userId == null) {
      throw Exception("User ID not found in local storage");
    }

    await _authRepo.changeEmail(
      userId: userId,
      email: newEmail,
    );

    email.value = newEmail;

    await PrefHelper.saveUserEmail(newEmail);

    AppSnackbar.show(
      position: SnackPosition.TOP,
      title: "Email Updated".tr,
      message: "Your email has been changed successfully.".tr,
      icon: Icons.check_circle_outline,
      iconColor: Colors.green,
    );

  } catch (e) {
    AppSnackbar.show(
      position: SnackPosition.TOP,
      title: "Error".tr,
      message: e.toString(),
      icon: Icons.error_outline,
      iconColor: theme.colorScheme.error,
    );
  } finally {
    isLoading.value = false;
  }
}
Future<void> resendCode() async {
  if (!isResendEnabled.value) return;

  try {
    isLoading.value = true;

    await _authRepo.resendVerificationEmail(
      email: email.value,
    );

    startResendTimer();

    AppSnackbar.show(
      position: SnackPosition.TOP,
      title: "Email Sent".tr,
      message:
          "A new verification email has been sent.".tr,
      icon: Icons.check_circle_outline,
      iconColor: Colors.green,
    );
  } catch (e) {
    AppSnackbar.show(
      position: SnackPosition.TOP,
      title: "Error",
      message: e.toString(),
      icon: Icons.error_outline,
      iconColor: theme.colorScheme.error,
    );
  } finally {
    isLoading.value = false;
  }
}
  void updateEmailAndResend(String newEmail) {
    email.value = newEmail;

    // 1. Call your backend API here to update the email and send a new OTP
    // apiService.updateEmailAndSendOTP(newEmail);

    // 2. Restart your resend timer
    // startTimer();

    // 3. Clear the old code input field
  }

  //------------states -----------------
  var isLoading = false.obs;

  Future<void> verifyEmail() async {
  try {
    isLoading.value = true;

    final user = await _authRepo.verifiedLogin(
      email: email.value,
      password: password,
    );

    // Save token
    if (user.token != null) {
      await PrefHelper.saveToken(user.token!);
    }

    // Save user info
    await PrefHelper.saveUserId(user.id);

    await PrefHelper.saveUserName(
      '${user.firstName} ${user.lastName}',
    );

    await PrefHelper.saveUserEmail(
      user.email,
    );

    await PrefHelper.saveUserPhone(
      user.phoneNumber,
    );

    await PrefHelper.saveBusinessName(
      user.businessName,
    );

    AppSnackbar.show(
      title: "Success".tr,
      message: "Email verified successfully".tr,
      icon: Icons.check_circle_outline,
      iconColor: Colors.green,
    );

    print("✅ TOKEN = ${user.token}");

    Get.offAllNamed('/ownerHome');
  } catch (e) {
    AppSnackbar.show(
      title: "Verification Failed".tr,
      message: e.toString(),
      icon: Icons.error_outline,
      iconColor: theme.colorScheme.error,
    );
  } finally {
    isLoading.value = false;
  }
}


  

}