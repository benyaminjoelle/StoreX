import 'package:get/get.dart';
import 'package:storex/features/auth/controllers/user_verification_controller.dart';

class UserVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserVerificationController>(() => UserVerificationController());
  }
}