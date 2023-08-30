import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/case/case.dart';
import '../../models/case/case_item.dart';
import '../apis/case_api.dart';

class LocalCase {
  static const String boxTitle = 'cases';
  static Future<Box<Case>> get openBox async =>
      await Hive.openBox<Case>(boxTitle);

  static Future<void> get closeBox async => Hive.box<Case>(boxTitle).close();
  static Box<Case> get _box => Hive.box<Case>(boxTitle);

  Future<Box<Case>> refresh() async {
    final bool isOpen = Hive.box<Case>(boxTitle).isOpen;
    if (isOpen) {
      return _box;
    } else {
      return await Hive.openBox<Case>(boxTitle);
    }
  }

  void add(Case value) async {
    try {
      await _box.put(value.caseID, value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<Case> caseByID(String id) async {
    final Case? user = _box.get(id);
    return user ?? await _load(id);
  }

  Future<List<Case>> caseByDate(DateTime date) async {
    return _box.values
        .where((Case element) =>
            element.reigsterDate.year == date.year &&
            element.reigsterDate.month == date.month &&
            element.reigsterDate.day == date.day)
        .toList();
  }

  List<Case> get cases => _box.values.toList();

  Future<Case> _load(String id) async {
    return await CaseAPI().caseByID(id) ?? _null;
  }

  Case get _null => Case(
        caseID: '',
        tokenID: '',
        patientID: '',
        departmentID: '',
        doctorID: '',
        operatorID: '',
        counterID: '',
        items: <CaseItem>[],
        discountInPercent: 0,
        discountInRupees: 0,
        payable: 0,
        paidAmount: 0,
        reigsterDate: DateTime.now(),
        lastUpdate: DateTime.now(),
        isLive: true,
      );
}
