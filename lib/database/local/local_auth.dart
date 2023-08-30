import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user/app_user.dart';

class LocalAuth {
  static late SharedPreferences? _preferences;
  static Future<void> init() async =>
      _preferences = await SharedPreferences.getInstance();

  static const String _currentUser = 'CURRENT_USER';
  static const String _uidKey = 'UID_KEY';
  static const String _isAdmin = 'IS_ADMIN';

  Future<void> setCurrentUser(AppUser value) =>
      _preferences!.setString(_currentUser, value.toJson());
  Future<void> setUID(String value) => _preferences!.setString(_uidKey, value);
  Future<void> setIsAdmin(bool value) => _preferences!.setBool(_isAdmin, value);

  static String get uid => _preferences?.getString(_uidKey) ?? '';
  static bool get isAdmin => _preferences?.getBool(_isAdmin) ?? false;

  AppUser? currentUser() {
    final String? result = _preferences?.getString(_currentUser);
    if (result == null) return null;
    return AppUser.fromJson(result);
  }
}
