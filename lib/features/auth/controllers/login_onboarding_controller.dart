import 'package:get/get.dart';

class LoginOnboardingController extends GetxController {
  final RxString selectedRole = ''.obs;

  void selectRole(String role) {
    selectedRole.value = role;
  }

  bool isSelected(String role) {
    return selectedRole.value == role;
  }
}