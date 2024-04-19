import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static late final SharedPreferences _preferences;

  static Future init() async {
    return _preferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setString(String key, String value) async {
    return await _preferences.setString(key, value);
  }

  static Future<bool> setBool(String key, bool value) async {
    return await _preferences.setBool(key, value);
  }

  static String getString(String key) {
    return _preferences.getString(key) ?? '';
  }

  static bool? getBool(String key) {
    return _preferences.getBool(key);
  }
}
