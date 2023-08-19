import '../../functions/id_generator.dart';
import '../../functions/time_fun.dart';

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

  final String departmentID;
  final String title;
  final String registerBy;
  final DateTime registerDate;
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
