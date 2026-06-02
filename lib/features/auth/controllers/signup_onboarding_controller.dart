import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storex/core/constants/app_colors.dart';
import 'package:storex/features/auth/models/user_model.dart';
import 'package:storex/widgets/app_snackbar.dart';

class SignupOnboardingController extends GetxController {
  
  final Rxn<UserRole> selectedType = Rxn<UserRole>();

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
}