import 'package:shared_preferences/shared_preferences.dart';

class LocaleStorage {
  static const String _languageKey = 'app_language_code';

  final SharedPreferences _prefs;

  LocaleStorage(this._prefs);

  String? getLanguageCode() => _prefs.getString(_languageKey);

  Future<void> saveLanguageCode(String languageCode) async {
    await _prefs.setString(_languageKey, languageCode);
  }
}
