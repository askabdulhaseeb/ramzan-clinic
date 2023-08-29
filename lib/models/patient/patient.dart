import 'package:hive/hive.dart';

import '../../database/local/local_patient.dart';
import '../../enums/gender.dart';
import '../../functions/id_generator.dart';
import '../../functions/time_fun.dart';
part 'patient.g.dart';

@HiveType(typeId: 21)
class Patient {
  Patient({
    required this.name,
    required this.lastName,
    required this.gender,
    required this.cnic,
    required this.address,
    required this.phoneNumber,
    required this.dob,
    String? ecryptedPhoneNumber,
    String? fullAddress,
    String? patientID,
    DateTime? registerDate,
    DateTime? lastUpdate,
    this.isLive = false,
  })  : patientID = patientID ??
            IdGenerator.patientID(
                '$name$lastName-${DateTime.now().microsecondsSinceEpoch}'),
        registerDate = registerDate ?? DateTime.now(),
        lastUpdate = lastUpdate ?? DateTime.now(),
        ecryptedPhoneNumber =
            ecryptedPhoneNumber ?? _encryptNumber(phoneNumber),
        fullAddress = fullAddress == null
            ? address.toString()
            : fullAddress.isEmpty
                ? fullAddress.toString()
                : fullAddress;

  @HiveField(0)
  final String patientID;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String lastName;
  @HiveField(3)
  final Gender gender;
  @HiveField(4)
  final String cnic;
  @HiveField(5)
  final String address;
  @HiveField(6)
  final String fullAddress;
  @HiveField(7)
  String phoneNumber;
  @HiveField(8)
  final DateTime registerDate;
  @HiveField(9)
  final DateTime lastUpdate;
  @HiveField(10, defaultValue: false)
  bool isLive;
  @HiveField(11)
  String ecryptedPhoneNumber;
  @HiveField(12)
  DateTime dob;

  Map<String, dynamic> toMap() {
    if (!phoneNumber.trim().startsWith('+92')) {
      phoneNumber = '+92$phoneNumber';
    }
    return <String, dynamic>{
      'patient_id': patientID.trim(),
      'name': name.trim(),
      'last_name': lastName.trim(),
      'gender': gender.json,
      'cnic': cnic.trim(),
      'address': address.trim(),
      'full_address': fullAddress.trim(),
      'phone_number': phoneNumber.trim(),
      'dob': dob,
      'register_date': registerDate,
      'last_update': DateTime.now(),
      'is_live': true,
    };
  }

  static String _encryptNumber(String value) {
    return value.length > 5
        ? value.trim().replaceRange(5, null, '********')
        : value;
  }

  // ignore: sort_constructors_first
  factory Patient.fromMap(Map<String, dynamic> map) {
    final Patient patient = Patient(
      patientID: map['patient_id'] ?? '',
      name: map['name'] ?? '',
      lastName: map['last_name'] ?? '',
      gender: GenderFun.fromMap(map['gender'] ?? Gender.other.json),
      cnic: map['cnic'] ?? '',
      address: map['address'],
      fullAddress: map['full_address'] ?? '',
      phoneNumber: map['phone_number'] ?? '',
      dob: map['dob'] ?? '',
      ecryptedPhoneNumber: _encryptNumber(map['phone_number'] ?? ''),
      registerDate: TimeFun.parseTime(map['register_date']),
      lastUpdate: TimeFun.parseTime(map['last_update']),
      isLive: true,
    );
    LocalPatient().add(patient);
    return patient;
  }
}
