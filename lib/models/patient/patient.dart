import 'package:hive/hive.dart';

import '../../database/local/local_patient.dart';
import '../../enums/gender.dart';
import '../../functions/id_generator.dart';
import '../../functions/time_fun.dart';
import '../core/address.dart';
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
    String? fullAddress,
    String? patientID,
    DateTime? registerDate,
    DateTime? lastUpdate,
  })  : patientID = patientID ?? IdGenerator.patientID(name),
        registerDate = registerDate ?? DateTime.now(),
        lastUpdate = lastUpdate ?? DateTime.now(),
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
  final Address address;
  @HiveField(6)
  final String fullAddress;
  @HiveField(7)
  final String phoneNumber;
  @HiveField(8)
  final DateTime registerDate;
  @HiveField(9)
  final DateTime lastUpdate;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'patient_id': patientID,
      'name': name,
      'last_name': lastName,
      'gender': gender.json,
      'cnic': cnic,
      'address': address.toMap(),
      'full_address': fullAddress,
      'phone_number': phoneNumber,
      'register_date': registerDate,
      'last_update': lastUpdate,
    };
  }

  // ignore: sort_constructors_first
  factory Patient.fromMap(Map<String, dynamic> map) {
    final Patient patient = Patient(
      patientID: map['patient_id'] ?? '',
      name: map['name'] ?? '',
      lastName: map['last_name'] ?? '',
      gender: GenderFun.fromMap(map['gender'] ?? Gender.other.json),
      cnic: map['cnic'] ?? '',
      address: Address.fromMap(map['address'] as Map<String, dynamic>),
      fullAddress: map['full_address'] ?? '',
      phoneNumber: map['phone_number'] ?? '',
      registerDate: TimeFun.parseTime(map['register_date']),
      lastUpdate: TimeFun.parseTime(map['last_update']),
    );
    LocalPatient().add(patient);
    return patient;
  }
}
