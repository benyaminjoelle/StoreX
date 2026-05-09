import 'package:get/get.dart';
import 'package:storex/core/routes/app_routes.dart';
import 'package:storex/features/auth/views/login/login_onboarding.dart';
import 'package:storex/features/onboarding/binding/carousel_binding.dart';
import 'package:storex/features/onboarding/views/onboarding_view.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: AppRoutes.loginOnboarding,
      page: () =>  LoginOnboarding(),
     
    ),
  ];
}
