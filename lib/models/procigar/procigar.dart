import 'package:hive_flutter/hive_flutter.dart';

import '../../database/apis/auth_api.dart';
import '../../database/local/local_procigar.dart';
import '../../enums/procigar_type.dart';
import '../../functions/id_generator.dart';
import '../../functions/time_fun.dart';
part 'procigar.g.dart';

@HiveType(typeId: 31)
class Procigar {
  Procigar({
    required this.name,
    required this.fee,
    required this.discountInPercent,
    required this.type,
    String? testID,
    double? discountInRupees,
    String? addBy,
    DateTime? registerTime,
    DateTime? lastUpdate,
  })  : testID = testID ?? IdGenerator.procigarID(name),
        discountInRupees =
            discountInRupees ?? (fee * (discountInPercent / 100)),
        addBy = addBy ?? AuthAPI.uid,
        registerTime = registerTime ?? DateTime.now(),
        lastUpdate = lastUpdate ?? DateTime.now();

  @HiveField(0)
  final String testID;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final double fee;
  @HiveField(3)
  final double discountInPercent;
  @HiveField(4)
  final double discountInRupees;
  @HiveField(5)
  final String addBy;
  @HiveField(6)
  final DateTime registerTime;
  @HiveField(7)
  final DateTime lastUpdate;
  @HiveField(8)
  final ProcigarType type;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'test_id': testID,
      'name': name,
      'fee': fee,
      'discount_in_percent': discountInPercent,
      'discount_in_rupees': discountInRupees,
      'add_by': addBy,
      'type': type.json,
      'register_time': registerTime,
      'last_update': lastUpdate,
    };
  }

  // ignore: sort_constructors_first
  factory Procigar.fromMap(Map<String, dynamic> map) {
    final Procigar test = Procigar(
      testID: map['test_id'] ?? '',
      name: map['name'] ?? '',
      fee: map['fee'] ?? 0.0,
      discountInPercent: map['discount_in_percent'] ?? 0.0,
      discountInRupees: map['discount_in_rupees'] ?? 0.0,
      addBy: map['add_by'] ?? '',
      type: ProcigarTypeFun.fromJson(map['type'] ?? ProcigarType.test.json),
      registerTime: TimeFun.parseTime(map['register_time']),
      lastUpdate: TimeFun.parseTime(map['last_update']),
    );
    LocalProcigar().add(test);
    return test;
  }
}
