import 'package:shared_preferences/shared_preferences.dart';

class LanguageCacheHelper {
  static const String _languageKey = 'language_code';

  Future<String> getCachedLanguageCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_languageKey) ?? '';
  }

  Future<void> cacheLanguageCode(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, languageCode);
  }

  Future<void> clearLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_languageKey);
  }
}
