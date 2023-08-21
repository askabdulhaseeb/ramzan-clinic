import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';

import '../../models/core/department.dart';
import '../local/local_department.dart';

class DepartmentAPI {
  final CollectionReference _collection =
      Firestore.instance.collection('departments');

  Future<void> create(Department value) async {
    try {
      await _collection.document(value.departmentID).set(value.toMap());
      LocalDepartment().add(value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<Department?> department(String value) async {
    try {
      final Document doc = await _collection.document(value).get();
      final Department depart = Department.fromMap(doc.map);
      LocalDepartment().add(depart);
      return depart;
    } catch (e) {
      return null;
    }
  }
}
