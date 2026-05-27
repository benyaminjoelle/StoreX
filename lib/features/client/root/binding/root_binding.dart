import 'package:get/get.dart';
import 'package:storex/features/client/root/controller/root_controller.dart';

class ClientRootBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RootController>(
      () => RootController(),
    );
  }
}