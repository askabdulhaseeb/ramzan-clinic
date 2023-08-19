import '../../functions/time_fun.dart';
import '../core/department.dart';
import '../core/address.dart';
import '../core/routine.dart';

class AppUser {
  AppUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.imageURL,
    required this.department,
    required this.phoneNumber,
    required this.jobDescription,
    required this.salary,
    required this.address,
    required this.routine,
    required this.registerDate,
    required this.lastUpdate,
  });

  final String uid;
  final String name;
  final String email;
  final String imageURL;
  final Department department;
  final String phoneNumber;
  final String jobDescription;
  final double salary;
  final Address address;
  final Routine routine;
  final DateTime registerDate;
  final DateTime lastUpdate;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'image_url': imageURL,
      'department': department.toMap(),
      'phone_number': phoneNumber,
      'job_description': jobDescription,
      'salary': salary,
      'address': address.toMap(),
      'routine': routine.toMap(),
      'register_date': registerDate.millisecondsSinceEpoch,
      'last_update': lastUpdate.millisecondsSinceEpoch,
    };
  }

  // ignore: sort_constructors_first
  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      imageURL: map['image_url'] ?? '',
      department: Department.fromMap(map['department'] as Map<String, dynamic>),
      phoneNumber: map['phone_number'] ?? '',
      jobDescription: map['job_description'] ?? '',
      salary: map['salary'] ?? 0.0,
      address: Address.fromMap(map['address'] as Map<String, dynamic>),
      routine: Routine.fromMap(map['routine'] as Map<String, dynamic>),
      registerDate: TimeFun.parseTime(map['register_date']),
      lastUpdate: TimeFun.parseTime(map['last_update']),
    );
  }
}
