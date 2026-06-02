import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:storex/core/constants/theme.dart';

import 'package:storex/core/utils/pref_helper.dart';
import 'package:storex/localization/app_translation.dart';

import 'core/routes/app_pages.dart';
import 'core/routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load saved language
  final lang = await PrefHelper.getLanguage();

  runApp(MyApp(initialLang: lang));
}

class MyApp extends StatelessWidget {
  final String initialLang;

  const MyApp({
    super.key,
    required this.initialLang,
  });

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      // THEMES
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,

      // LOCALIZATION
      translations: AppTranslation(),
      locale: Locale(initialLang),
      fallbackLocale: const Locale('en'),

      // ROUTES
      initialRoute: AppRoutes.onboarding,
      getPages: AppPages.pages,
    );
  }
}