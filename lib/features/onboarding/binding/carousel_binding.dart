import 'package:get/get.dart';
import 'package:storex/features/onboarding/controller/onboarding_carousel_controller.dart';


class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingCarouselController>(
      () => OnboardingCarouselController(),
    );
  }
}