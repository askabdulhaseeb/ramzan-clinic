import 'package:hive/hive.dart';

import '../../database/apis/auth_api.dart';
import '../../database/local/local_department.dart';
import '../../functions/id_generator.dart';
import '../../functions/time_fun.dart';
part 'department.g.dart';

@HiveType(typeId: 201)
class Department {
  Department({
    required this.title,
    String? departmentID,
    String? registerBy,
    DateTime? registerDate,
    DateTime? lastUpdate,
    this.isActive = true,
  })  : departmentID = departmentID ?? IdGenerator.department(title),
        registerBy = registerBy ?? AuthAPI.uid,
        registerDate = registerDate ?? DateTime.now(),
        lastUpdate = lastUpdate ?? DateTime.now();

  @HiveField(0, defaultValue: 'null')
  final String departmentID;
  @HiveField(1, defaultValue: 'null')
  final String title;
  @HiveField(2, defaultValue: 'null')
  final String registerBy;
  @HiveField(3)
  final DateTime registerDate;
  @HiveField(4)
  final DateTime lastUpdate;
  @HiveField(5)
  bool isActive;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'department_id': departmentID,
      'title': title.trim(),
      'register_by': registerBy,
      'register_date': registerDate,
      'last_update': lastUpdate,
      'is_active': isActive,
    };
  }

  // ignore: sort_constructors_first
  factory Department.fromMap(Map<String, dynamic> map) {
    final Department depart = Department(
      departmentID: map['department_id'] ?? '',
      title: map['title'] ?? '',
      registerBy: map['register_by'] ?? '',
      registerDate: TimeFun.parseTime(map['register_date']),
      lastUpdate: TimeFun.parseTime(map['last_update']),
      isActive: map['is_active'] ?? false,
    );
    LocalDepartment().add(depart);
    return depart;
  }
}
