import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';

import '../../models/case/case.dart';
import '../local/local_case.dart';

class CaseAPI {
  final CollectionReference _collection =
      Firestore.instance.collection('cases');

  Future<void> create(Case value) async {
    try {
      await _collection.document(value.caseID).set(value.toMap());
      value.isLive = true;
    } catch (e) {
      value.isLive = false;
      debugPrint(e.toString());
    }
    LocalCase().add(value);
  }

  Future<Case?> caseByID(String value) async {
    try {
      final Document doc = await _collection.document(value).get();
      return Case.fromMap(doc.map);
    } catch (e) {
      return null;
    }
  }

  Future<void> loadAllByDate({
    required DateTime start,
    required DateTime end,
  }) async {
    final List<Document> docs = await _collection
        .where('reigster_date', isGreaterThanOrEqualTo: start)
        .where('reigster_date', isLessThanOrEqualTo: end)
        .get();
    for (Document element in docs) {
      Case.fromMap(element.map);
    }
  }

  Future<void> loadAllByOperator({
    required DateTime start,
    required DateTime end,
    required String operatorID,
  }) async {
    final List<Document> docs = await _collection
        .where('reigster_date', isGreaterThanOrEqualTo: start)
        .where('reigster_date', isLessThanOrEqualTo: end)
        .where('operator_id', isEqualTo: operatorID)
        .get();
    for (Document element in docs) {
      Case.fromMap(element.map);
    }
  }

  Future<void> loadAllByDoctor({
    required DateTime start,
    required DateTime end,
    required String doctorID,
  }) async {
    final List<Document> docs = await _collection
        .where('reigster_date', isGreaterThanOrEqualTo: start)
        .where('reigster_date', isLessThanOrEqualTo: end)
        .where('doctor_id', isEqualTo: doctorID)
        .get();
    for (Document element in docs) {
      Case.fromMap(element.map);
    }
  }

  Future<void> loadAllByCounterID(String counterID) async {
    final List<Document> docs =
        await _collection.where('counter_id', isEqualTo: counterID).get();
    for (Document element in docs) {
      Case.fromMap(element.map);
    }
  }

  Future<void> loadAllByPatientID(String patientID) async {
    final List<Document> docs =
        await _collection.where('patient_id', isEqualTo: patientID).get();
    for (Document element in docs) {
      Case.fromMap(element.map);
    }
  }
}
