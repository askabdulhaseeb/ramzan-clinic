import 'package:shared_preferences/shared_preferences.dart';

class LocalAuth {
  static late SharedPreferences? _preferences;
  static Future<void> init() async =>
      _preferences = await SharedPreferences.getInstance();

  static const String _uidKey = 'UID_KEY';
  static const String _isAdmin = 'IS_ADMIN';

  Future<void> setUID(String value) => _preferences!.setString(_uidKey, value);
  Future<void> setIsAdmin(bool value) => _preferences!.setBool(_isAdmin, value);

  static String get uid => _preferences?.getString(_uidKey) ?? '';
  static bool get isAdmin => _preferences?.getBool(_isAdmin) ?? false;
}
