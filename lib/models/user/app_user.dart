import 'package:hive_flutter/hive_flutter.dart';

import '../../database/local/local_user.dart';
import '../../functions/time_fun.dart';
import '../core/department.dart';
import '../core/address.dart';
import '../core/routine.dart';
part 'app_user.g.dart';

@HiveType(typeId: 11)
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
    this.password = '',
    this.isAdmin = false,
    this.isRegistered = true,
    String? fullAddress,
    DateTime? registerDate,
    DateTime? lastUpdate,
  })  : registerDate = registerDate ?? DateTime.now(),
        lastUpdate = lastUpdate ?? DateTime.now(),
        fullAddress = fullAddress == null
            ? address.toString()
            : fullAddress.isEmpty
                ? fullAddress.toString()
                : fullAddress;

  @HiveField(0)
  final String uid;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final bool isAdmin;
  @HiveField(4)
  final String imageURL;
  @HiveField(5)
  final Department department;
  @HiveField(6)
  final String phoneNumber;
  @HiveField(7)
  final String jobDescription;
  @HiveField(8)
  final double salary;
  @HiveField(9)
  final Address address;
  @HiveField(10)
  final String fullAddress;
  @HiveField(11)
  final Routine routine;
  @HiveField(12)
  final DateTime registerDate;
  @HiveField(13)
  final DateTime lastUpdate;
  @HiveField(14)
  final String password;
  @HiveField(15)
  final bool isRegistered;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'password': password,
      'image_url': imageURL,
      'department': department.toMap(),
      'phone_number': phoneNumber,
      'job_description': jobDescription,
      'salary': salary,
      'address': address.toMap(),
      'full_address': fullAddress,
      'routine': routine.toMap(),
      'register_date': registerDate,
      'last_update': lastUpdate,
      'is_admin': isAdmin,
      'is_registered': isRegistered,
    };
  }

  // ignore: sort_constructors_first
  factory AppUser.fromMap(Map<String, dynamic> map) {
    final AppUser user = AppUser(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      isAdmin: map['is_admin'] ?? false,
      imageURL: map['image_url'] ?? '',
      department: Department.fromMap(map['department'] as Map<String, dynamic>),
      phoneNumber: map['phone_number'] ?? '',
      jobDescription: map['job_description'] ?? '',
      fullAddress: map['full_address'] ?? '',
      salary: map['salary'] ?? 0.0,
      address: Address.fromMap(map['address'] as Map<String, dynamic>),
      routine: Routine.fromMap(map['routine'] as Map<String, dynamic>),
      registerDate: TimeFun.parseTime(map['register_date']),
      lastUpdate: TimeFun.parseTime(map['last_update']),
      isRegistered: map['is_registered'] ?? false,
    );
    LocalUser().add(user);
    return user;
  }
}
