import 'package:hive_flutter/hive_flutter.dart';

import '../../database/local/local_counter.dart';
import '../../functions/time_fun.dart';
part 'counter.g.dart';

@HiveType(typeId: 53)
class Counter {
  Counter({
    required this.counterID,
    required this.uid,
    required this.counterCases,
    required this.dayCases,
    required this.openingCash,
    required this.cashInCounter,
    required this.isOpened,
    required this.openingTime,
    required this.closingTime,
    this.isLive = false,
  });

  @HiveField(0)
  final String counterID;
  @HiveField(1)
  final String uid;
  @HiveField(2)
  int counterCases;
  @HiveField(3)
  int dayCases;
  @HiveField(4)
  final double openingCash;
  @HiveField(5)
  double cashInCounter;
  @HiveField(6)
  bool isOpened;
  @HiveField(7)
  final DateTime openingTime;
  @HiveField(8)
  final DateTime closingTime;
  @HiveField(9)
  bool isLive;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'counter_id': counterID,
      'uid': uid,
      'counter_cases': counterCases,
      'day_cases': dayCases,
      'opening_cash': openingCash,
      'cash_in_counter': cashInCounter,
      'is_opened': isOpened,
      'opening_time': openingTime,
      'closing_time': DateTime.now(),
      'is_live': true,
    };
  }

  // ignore: sort_constructors_first
  factory Counter.fromMap(Map<String, dynamic> map) {
    final Counter obj = Counter(
      counterID: map['counter_id'] ?? '',
      uid: map['uid'] ?? '',
      counterCases: map['counter_cases'] ?? 0,
      dayCases: map['day_cases'] ?? 0,
      openingCash: map['opening_cash'] ?? 0.0,
      cashInCounter: map['cash_in_counter'] ?? 0.0,
      isOpened: map['is_opened'] ?? false,
      isLive: true,
      openingTime: TimeFun.parseTime(map['opening_time']),
      closingTime: TimeFun.parseTime(map['closing_time']),
    );
    LocalCounter().add(obj);
    return obj;
  }
}
