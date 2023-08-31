import 'package:hive_flutter/hive_flutter.dart';

import '../../database/local/local_auth.dart';
import '../../functions/id_generator.dart';
import '../../functions/time_fun.dart';
part 'counter.g.dart';

@HiveType(typeId: 53)
class Counter {
  Counter({
    required this.openingCash,
    required this.cashInCounter,
    String? counterID,
    String? uid,
    this.isOpened = true,
    this.counterCases = 0,
    this.dayCases = 0,
    DateTime? lastUpdate,
    DateTime? openingTime,
    DateTime? closingTime,
    this.isLive = false,
  })  : counterID = counterID ?? IdGenerator.counterID(),
        uid = uid ?? LocalAuth.uid,
        lastUpdate = lastUpdate ?? DateTime.now(),
        openingTime = openingTime ?? DateTime.now(),
        closingTime = closingTime ?? DateTime.now();

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
  @HiveField(10)
  final DateTime lastUpdate;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'counter_id': counterID,
      'uid': uid,
      'counter_cases': counterCases,
      'opening_cash': openingCash,
      'cash_in_counter': cashInCounter,
      'is_opened': isOpened,
      'opening_time': openingTime,
      'last_update': DateTime.now(),
      'closing_time': DateTime.now(),
      'is_live': true,
    };
  }

  Map<String, dynamic> updateMap() {
    return <String, dynamic>{
      'uid': uid,
      'counter_cases': counterCases,
      'opening_cash': openingCash,
      'cash_in_counter': cashInCounter,
      'is_opened': isOpened,
      'last_update': DateTime.now(),
      'closing_time': DateTime.now(),
      'is_live': true,
    };
  }

  // ignore: sort_constructors_first
  factory Counter.fromMap(Map<String, dynamic> map) {
    return Counter(
      counterID: map['counter_id'] ?? '',
      uid: map['uid'] ?? '',
      counterCases: map['counter_cases'] ?? 0,
      openingCash: map['opening_cash'] ?? 0.0,
      cashInCounter: map['cash_in_counter'] ?? 0.0,
      isOpened: map['is_opened'] ?? false,
      isLive: true,
      lastUpdate: TimeFun.parseTime(map['last_update']),
      openingTime: TimeFun.parseTime(map['opening_time']),
      closingTime: TimeFun.parseTime(map['closing_time']),
    );
  }

  onAddCase(double amount) {
    cashInCounter += amount;
    dayCases++;
    counterCases++;
  }
}
