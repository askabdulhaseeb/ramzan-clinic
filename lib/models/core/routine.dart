import 'package:hive/hive.dart';

import '../../enums/day.dart';
part 'routine.g.dart';

@HiveType(typeId: 203)
class Routine {
  Routine({
    required this.day,
    this.staringHour = 9,
    this.staringMinute = 0,
    this.endingHour = 9,
    this.endingMinute = 0,
  });

  @HiveField(0)
  final Day day;
  @HiveField(1, defaultValue: 0)
  int staringHour;
  @HiveField(2, defaultValue: 0)
  int staringMinute;
  @HiveField(3, defaultValue: 0)
  int endingHour;
  @HiveField(4, defaultValue: 0)
  int endingMinute;

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
  @override
  String toString() =>
      '${day.short} - $staringHour:$staringMinute , $endingHour:$endingMinute';
}
