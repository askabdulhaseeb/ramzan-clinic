import '../../enums/gender.dart';
import '../../functions/id_generator.dart';
import '../../functions/time_fun.dart';
import '../core/address.dart';

class Patient {
  Patient({
    required this.name,
    required this.lastName,
    required this.gender,
    required this.cnic,
    required this.address,
    required this.fullAddress,
    required this.phoneNumber,
    String? patientID,
    DateTime? registerDate,
    DateTime? lastUpdate,
  })  : patientID = patientID ?? IdGenerator.patientID(name),
        registerDate = registerDate ?? DateTime.now(),
        lastUpdate = lastUpdate ?? DateTime.now();

  final String patientID;
  final String name;
  final String lastName;
  final Gender gender;
  final String cnic;
  final Address address;
  final String fullAddress;
  final String phoneNumber;
  final DateTime registerDate;
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
    return Patient(
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
  }
}
