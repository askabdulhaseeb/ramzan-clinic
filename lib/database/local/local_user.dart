import 'package:flutter/rendering.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/user/app_user.dart';
import '../apis/user_api.dart';

class LocalUser {
  static const String boxTitle = 'users';
  static Future<Box<AppUser>> get openBox async =>
      await Hive.openBox<AppUser>(boxTitle);

  static Future<void> get closeBox async => Hive.box<AppUser>(boxTitle).close();
  static Box<AppUser> get _box => Hive.box<AppUser>(boxTitle);

  Future<Box<AppUser>> refresh() async {
    final bool isOpen = Hive.box<AppUser>(boxTitle).isOpen;
    if (isOpen) {
      return _box;
    } else {
      return await Hive.openBox<AppUser>(boxTitle);
    }
  }

  void add(AppUser value) async {
    try {
      await _box.put(value.uid, value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<AppUser> user(String uid) async {
    final AppUser? user = _box.get(uid);
    return user ?? await _load(uid);
  }

  List<AppUser> userByDepartment(String? value) {
    return value == null
        ? <AppUser>[]
        : _box.values
            .where((AppUser element) => element.departmentID == value)
            .toList();
  }

  Future<AppUser?> login({
    required String email,
    required String password,
  }) async {
    try {
      final Box<AppUser> box = await refresh();
      final AppUser result = box.values.firstWhere(
        (AppUser element) =>
            element.email == email && element.password == password,
        orElse: () => _null,
      );
      print('${result.uid} - ${(result.uid == _null.uid)}');
      return result.uid == _null.uid ? null : result;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<AppUser> _load(String uid) async {
    return await UserAPI().user(uid) ?? _null;
  }

  AppUser get _null => AppUser(
        uid: '',
        name: 'Null',
        email: 'null@null.com',
        imageURL: '',
        departmentID: '',
        phoneNumber: <String>[],
        jobDescription: '',
        salary: 0.0,
      );
}
