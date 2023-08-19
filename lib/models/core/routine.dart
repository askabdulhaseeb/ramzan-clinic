import 'package:hive/hive.dart';

import '../../enums/day.dart';
part 'routine.g.dart';

@HiveType(typeId: 203)
class Routine {
  Routine({
    required this.day,
    required this.staringHour,
    required this.staringMinute,
    required this.endingHour,
    required this.endingMinute,
  });

  @HiveField(0)
  final Day day;
  @HiveField(1, defaultValue: 0)
  final int staringHour;
  @HiveField(2, defaultValue: 0)
  final int staringMinute;
  @HiveField(3, defaultValue: 0)
  final int endingHour;
  @HiveField(4, defaultValue: 0)
  final int endingMinute;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'day': day.json,
      'staring_hour': staringHour,
      'staring_minute': staringMinute,
      'ending_hour': endingHour,
      'ending_minute': endingMinute,
    };
  }

  // ignore: sort_constructors_first
  factory Routine.fromMap(Map<String, dynamic> map) {
    return Routine(
      day: DayFun.fromMap(map['day'] ?? Day.sunday.json),
      staringHour: map['staring_hour'] ?? 0,
      staringMinute: map['staring_minute'] ?? 0,
      endingHour: map['ending_hour'] ?? 0,
      endingMinute: map['ending_minute'] ?? 0,
    );
  }
}
