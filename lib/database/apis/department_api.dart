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
      return Department.fromMap(doc.map);
    } catch (e) {
      return null;
    }
  }

  Future<void> loadAll() async {
    final List<Document> docs = await _collection.get();
    for (Document element in docs) {
      Department.fromMap(element.map);
    }
  }
}
