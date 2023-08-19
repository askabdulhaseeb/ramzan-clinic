import 'package:hive/hive.dart';

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
  })  : departmentID = departmentID ?? IdGenerator.department(title),
        registerBy = registerBy ?? '',
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'department_id': departmentID,
      'title': title,
      'register_by': registerBy,
      'register_date': registerDate,
      'last_update': lastUpdate,
    };
  }

  // ignore: sort_constructors_first
  factory Department.fromMap(Map<String, dynamic> map) {
    return Department(
      departmentID: map['department_id'] ?? '',
      title: map['title'] ?? '',
      registerBy: map['register_by'] ?? '',
      registerDate: TimeFun.parseTime(map['register_date']),
      lastUpdate: TimeFun.parseTime(map['last_update']),
    );
  }
}
