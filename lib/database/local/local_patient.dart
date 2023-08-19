import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../enums/gender.dart';
import '../../models/core/address.dart';
import '../../models/patient/patient.dart';
import '../apis/patient_api.dart';

class LocalPatient {
  static const String boxTitle = 'patients';
  static Future<Box<Patient>> get openBox async =>
      await Hive.openBox<Patient>(boxTitle);

  static Future<void> get closeBox async => Hive.box<Patient>(boxTitle).close();
  static Box<Patient> get _box => Hive.box<Patient>(boxTitle);

  Future<Box<Patient>> refresh() async {
    final bool isOpen = Hive.box<Patient>(boxTitle).isOpen;
    if (isOpen) {
      return _box;
    } else {
      return await Hive.openBox<Patient>(boxTitle);
    }
  }

  void add(Patient value) async {
    try {
      await _box.put(value.patientID, value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<Patient> patient(String id) async {
    final Patient? user = _box.get(id);
    return user ?? await _loadUser(id);
  }

  Future<Patient> _loadUser(String id) async {
    return await PatientAPI().patient(id) ?? _null;
  }

  Patient get _null => Patient(
        name: 'null',
        lastName: 'null',
        gender: Gender.other,
        cnic: 'null',
        address: Address(
            province: 'null', district: 'null', city: 'null', town: 'null'),
        phoneNumber: 'null',
      );
}
