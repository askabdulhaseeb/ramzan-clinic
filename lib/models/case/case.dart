import '../../functions/time_fun.dart';
import 'case_item.dart';

class Case {
  Case({
    required this.caseID,
    required this.tokenID,
    required this.patientID,
    required this.doctorID,
    required this.operatorID,
    required this.counterID,
    required this.items,
    required this.discountInPercent,
    required this.discountInRupees,
    required this.payable,
    required this.paidAmount,
    required this.reigsterDate,
    required this.lastUpdate,
  });

  final String caseID;
  final String tokenID;
  final String patientID;
  final String doctorID;
  final String operatorID;
  final String counterID;
  final List<CaseItem> items;
  final double discountInPercent;
  final double discountInRupees;
  final double payable;
  final double paidAmount;
  final DateTime reigsterDate;
  final DateTime lastUpdate;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'case_id': caseID,
      'token_id': tokenID,
      'patient_id': patientID,
      'doctor_id': doctorID,
      'operator_id': operatorID,
      'counter_id': counterID,
      'items': items.map((CaseItem x) => x.toMap()).toList(),
      'discount_in_percent': discountInPercent,
      'discount_in_rupees': discountInRupees,
      'payable': payable,
      'paid_amount': paidAmount,
      'reigster_date': reigsterDate.millisecondsSinceEpoch,
      'last_update': lastUpdate.millisecondsSinceEpoch,
    };
  }

  // ignore: sort_constructors_first
  factory Case.fromMap(Map<String, dynamic> map) {
    return Case(
      caseID: map['case_id'] ?? '',
      tokenID: map['token_id'] ?? '',
      patientID: map['patient_id'] ?? '',
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
    );
  }
}
