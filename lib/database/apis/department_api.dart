import 'package:firedart/firedart.dart';

import '../../models/core/department.dart';

class DepartmentAPI {
  final CollectionReference _collection =
      Firestore.instance.collection('departments');

  Future<void> create(Department value) async {
    await _collection.document(value.departmentID).set(value.toMap());
  }

  Future<Department?> department(String value) async {
    try {
      final Document doc = await _collection.document(value).get();
      return Department.fromMap(doc.map);
    } catch (e) {
      return null;
    }
  }
}
