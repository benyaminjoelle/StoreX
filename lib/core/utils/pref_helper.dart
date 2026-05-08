import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper {
  static const String _langKey = 'app_language';

  /// Save selected language
  static Future<void> saveLanguage(String langCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_langKey, langCode);
  }

  /// Get saved language
  static Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_langKey) ?? 'en';
  }

  /// Clear saved language (optional)
  static Future<void> clearLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_langKey);
  }
}