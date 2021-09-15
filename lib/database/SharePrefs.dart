import 'package:shared_preferences/shared_preferences.dart';

abstract class SharePrefs {
  static SharedPreferences sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static const String KEY_IS_LOGIN = 'is_logged_in';
  static const String KEY_ID_TOKEN = 'key_id_token';
  static const String KEY_LOGGED_IN_USER_ID = 'key_logged_in_user_id';

  static set isLoggedIn(bool loggedIn) {
    sharedPreferences.setBool(KEY_IS_LOGIN, loggedIn);
  }

  static bool get isLoggedIn => sharedPreferences.getBool(KEY_IS_LOGIN) ?? false;

  static String get idToken => sharedPreferences.getString(KEY_ID_TOKEN) ?? '';

  static set idToken(String idToken) =>
      sharedPreferences.setString(KEY_ID_TOKEN, idToken);

  static String get loggedInUserId =>
      sharedPreferences.getString(KEY_LOGGED_IN_USER_ID) ?? '';

  static set loggedInUserId(String id) =>
      sharedPreferences.setString(KEY_LOGGED_IN_USER_ID, id);
}
