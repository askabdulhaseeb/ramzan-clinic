import 'package:hive_flutter/hive_flutter.dart';

import '../../database/local/local_user.dart';
import '../../enums/day.dart';
import '../../functions/time_fun.dart';
import '../core/routine.dart';
part 'app_user.g.dart';

@HiveType(typeId: 11)
class AppUser {
  AppUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.imageURL,
    required this.departmentID,
    required this.phoneNumber,
    required this.jobDescription,
    required this.salary,
    this.addressID,
    List<Routine>? routine,
    this.password = '',
    this.isAdmin = false,
    this.isRegistered = false,
    String? fullAddress,
    DateTime? registerDate,
    DateTime? lastUpdate,
  })  : registerDate = registerDate ?? DateTime.now(),
        lastUpdate = lastUpdate ?? DateTime.now(),
        fullAddress = fullAddress ?? '',
        routine = routine ??
            <Routine>[
              Routine(day: Day.monday),
              Routine(day: Day.tuesday),
              Routine(day: Day.wednesday),
              Routine(day: Day.thursday),
              Routine(day: Day.friday),
              Routine(day: Day.saturday),
              Routine(day: Day.sunday),
            ];

  @HiveField(0)
  String uid;
  @HiveField(1)
  String name;
  @HiveField(2)
  final String email;
  @HiveField(3)
  bool isAdmin;
  @HiveField(4)
  String imageURL;
  @HiveField(5)
  String departmentID;
  @HiveField(6)
  List<String> phoneNumber;
  @HiveField(7)
  String jobDescription;
  @HiveField(8)
  double salary;
  @HiveField(9)
  String? addressID;
  @HiveField(10)
  String fullAddress;
  @HiveField(11)
  final List<Routine> routine;
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
      'department_id': departmentID,
      'phone_number': phoneNumber,
      'job_description': jobDescription,
      'salary': salary,
      'address_id': addressID,
      'full_address': fullAddress,
      'routine': routine.map((Routine e) => e.toMap()).toList(),
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
      departmentID: map['department_id'],
      phoneNumber: List<String>.from(map['phone_number'] ?? <String>[]),
      jobDescription: map['job_description'] ?? '',
      fullAddress: map['full_address'] ?? '',
      salary: map['salary'] ?? 0.0,
      addressID: map['address_id'] ?? '',
      routine: List<Routine>.from(
        (map['routine'] as List<dynamic>).map<Routine>(
            (dynamic x) => Routine.fromMap(x as Map<String, dynamic>)),
      ),
      registerDate: TimeFun.parseTime(map['register_date']),
      lastUpdate: TimeFun.parseTime(map['last_update']),
      isRegistered: map['is_registered'] ?? false,
    );
    LocalUser().add(user);
    return user;
  }
}
