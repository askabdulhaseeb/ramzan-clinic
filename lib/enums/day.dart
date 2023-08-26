import 'package:hive/hive.dart';
part 'day.g.dart';

@HiveType(typeId: 211)
enum Day {
  @HiveField(0)
  monday('Monday', 'Mon', 'monday'),
  @HiveField(1)
  tuesday('Tuesday', 'Tue', 'tuesday'),
  @HiveField(2)
  wednesday('Wednesday', 'Wed', 'wednesday'),
  @HiveField(3)
  thursday('Thursday', 'Thu', 'thursday'),
  @HiveField(4)
  friday('Friday', 'Fri', 'friday'),
  @HiveField(5)
  saturday('Saturday', 'Sat', 'saturday'),
  @HiveField(6)
  sunday('Sunday', 'Sun', 'sunday');

  const Day(this.title, this.short, this.json);
  final String title;
  final String short;
  final String json;
}

class DayFun {
  static Day fromMap(String expression) {
    switch (expression) {
      case 'monday':
        return Day.monday;
      case 'tuesday':
        return Day.tuesday;
      case 'wednesday':
        return Day.wednesday;
      case 'thursday':
        return Day.thursday;
      case 'friday':
        return Day.friday;
      case 'saturday':
        return Day.saturday;
      case 'sunday':
        return Day.sunday;
      default:
        return Day.sunday;
    }
  }
}
