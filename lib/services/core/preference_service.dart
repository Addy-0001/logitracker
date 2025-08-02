import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  static SharedPreferences? _sharedPreferences;
  static const String keyAccessToken = 'accesstoken';
  static const String keyUsername = 'username';

  static Future<PreferenceService> getInstance() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return PreferenceService._();
  }

  PreferenceService._();

  // Access Token get and set
  set accessToken(String value) {
    _sharedPreferences!.setString(keyAccessToken, value);
  }

  String get accessToken {
    final value = (_sharedPreferences!.getString(keyAccessToken) ?? '');
    return value;
  }

  // user name get and set
  set userName(String value) {
    _sharedPreferences!.setString(keyUsername, value);
  }

  String get userName {
    final value = (_sharedPreferences!.getString(keyUsername) ?? "");
    return value;
  }

  Future<void> clearSession() async {
    await _sharedPreferences!.remove(keyAccessToken);
  }

  Future<void> clearAll() async {
    await _sharedPreferences!.clear();
  }
}
