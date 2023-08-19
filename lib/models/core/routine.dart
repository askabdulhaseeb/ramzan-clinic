import '../../enums/day.dart';

class Routine {
  Routine({
    required this.day,
    required this.staringHour,
    required this.staringMinute,
    required this.endingHour,
    required this.endingMinute,
  });

  final Day day;
  final int staringHour;
  final int staringMinute;
  final int endingHour;
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
