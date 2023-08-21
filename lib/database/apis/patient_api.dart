import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';

import '../../models/patient/patient.dart';
import '../local/local_patient.dart';

class PatientAPI {
  final CollectionReference _collection =
      Firestore.instance.collection('patients');

  Future<void> create(Patient value) async {
    try {
      await _collection.document(value.patientID).set(value.toMap());
      LocalPatient().add(value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<Patient?> patient(String value) async {
    try {
      final Document doc = await _collection.document(value).get();
      final Patient pat = Patient.fromMap(doc.map);
      LocalPatient().add(pat);
      return pat;
    } catch (e) {
      return null;
    }
  }
}
