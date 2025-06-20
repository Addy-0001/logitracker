import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String? getString(String key) => _prefs?.getString(key);
  static Future<bool> setString(String key, String value) =>
      _prefs?.setString(key, value) ?? Future.value(false);
}
