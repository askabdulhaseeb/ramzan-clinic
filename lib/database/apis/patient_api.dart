import 'package:firedart/firedart.dart';

import '../../models/patient/patient.dart';

class PatientAPI {
  final CollectionReference _collection =
      Firestore.instance.collection('patients');

  Future<void> create(Patient value) async {
    await _collection.document(value.patientID).set(value.toMap());
  }

  Future<Patient?> patient(String value) async {
    try {
      final Document doc = await _collection.document(value).get();
      return Patient.fromMap(doc.map);
    } catch (e) {
      return null;
    }
  }
}
