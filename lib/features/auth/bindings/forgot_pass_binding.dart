import 'package:get/get.dart';
import 'package:storex/features/auth/controllers/forgot_pass_controller.dart';

class ForgotPassBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ForgotPassController>(() => ForgotPassController());
  }
}