import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/core/department.dart';
import '../apis/department_api.dart';

class LocalDepartment {
  static const String boxTitle = 'departments';
  static Future<Box<Department>> get openBox async =>
      await Hive.openBox<Department>(boxTitle);

  static Future<void> get closeBox async =>
      Hive.box<Department>(boxTitle).close();
  static Box<Department> get _box => Hive.box<Department>(boxTitle);

  Future<Box<Department>> refresh() async {
    final bool isOpen = Hive.box<Department>(boxTitle).isOpen;
    if (isOpen) {
      return _box;
    } else {
      return await Hive.openBox<Department>(boxTitle);
    }
  }

  void add(Department value) async {
    try {
      await _box.put(value.departmentID, value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<Department> department(String id) async {
    final Department? user = _box.get(id);
    return user ?? await _load(id);
  }

  List<Department> get departments => _box.values.toList();

  Future<Department> _load(String id) async {
    return await DepartmentAPI().department(id) ?? _null;
  }

  Department get _null => Department(title: 'null');
}
