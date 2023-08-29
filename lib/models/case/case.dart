import 'package:hive_flutter/hive_flutter.dart';

import '../../database/local/local_case.dart';
import '../../functions/time_fun.dart';
import 'case_item.dart';
part 'case.g.dart';

@HiveType(typeId: 51)
class Case {
  Case({
    required this.caseID,
    required this.tokenID,
    required this.patientID,
    required this.departmentID,
    required this.doctorID,
    required this.operatorID,
    required this.counterID,
    required this.items,
    required this.discountInPercent,
    required this.discountInRupees,
    required this.payable,
    required this.paidAmount,
    this.isLive = false,
    DateTime? reigsterDate,
    DateTime? lastUpdate,
  })  : reigsterDate = reigsterDate ?? DateTime.now(),
        lastUpdate = lastUpdate ?? DateTime.now();

  @HiveField(0)
  final String caseID;
  @HiveField(1)
  final String tokenID;
  @HiveField(2)
  final String patientID;
  @HiveField(3)
  final String doctorID;
  @HiveField(4)
  final String operatorID;
  @HiveField(5)
  final String counterID;
  @HiveField(6)
  final List<CaseItem> items;
  @HiveField(7)
  final double discountInPercent;
  @HiveField(8)
  final double discountInRupees;
  @HiveField(9)
  final double payable;
  @HiveField(10)
  final double paidAmount;
  @HiveField(11)
  final DateTime reigsterDate;
  @HiveField(12)
  final DateTime lastUpdate;
  @HiveField(13, defaultValue: false)
  final bool isLive;
  @HiveField(14)
  final String departmentID;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'case_id': caseID,
      'token_id': tokenID,
      'patient_id': patientID,
      'department_id': departmentID,
      'doctor_id': doctorID,
      'operator_id': operatorID,
      'counter_id': counterID,
      'items': items.map((CaseItem x) => x.toMap()).toList(),
      'discount_in_percent': discountInPercent,
      'discount_in_rupees': discountInRupees,
      'payable': payable,
      'paid_amount': paidAmount,
      'reigster_date': reigsterDate,
      'last_update': DateTime.now(),
      'is_live': true,
    };
  }

  // ignore: sort_constructors_first
  factory Case.fromMap(Map<String, dynamic> map) {
    final Case obj = Case(
      caseID: map['case_id'] ?? '',
      tokenID: map['token_id'] ?? '',
      patientID: map['patient_id'] ?? '',
      departmentID: map['department_id'] ?? '',
      doctorID: map['doctor_id'] ?? '',
      operatorID: map['operator_id'] ?? '',
      counterID: map['counter_id'] ?? '',
      items: List<CaseItem>.from(
        (map['items'] as List<dynamic>).map<CaseItem>(
          (dynamic x) => CaseItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
      discountInPercent: map['discount_in_percent'] ?? 0.0,
      discountInRupees: map['discount_in_rupees'] ?? 0.0,
      payable: map['payable'] ?? 0.0,
      paidAmount: map['paid_amount'] ?? 0.0,
      reigsterDate: TimeFun.parseTime(map['reigster_date']),
      lastUpdate: TimeFun.parseTime(map['last_update']),
      isLive: true,
    );
    LocalCase().add(obj);
    return obj;
  }
}
