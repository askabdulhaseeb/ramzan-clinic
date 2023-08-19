import 'package:hive/hive.dart';
part 'gender.g.dart';

@HiveType(typeId: 212)
enum Gender {
  @HiveField(0)
  male('Male', 'male'),
  @HiveField(1)
  female('Female', 'female'),
  @HiveField(2)
  other('other', 'other');

  const Gender(this.title, this.json);
  final String title;
  final String json;
}

class GenderFun {
  static Gender fromMap(String expression) {
    switch (expression) {
      case 'male':
        return Gender.male;
      case 'female':
        return Gender.female;
      case 'other':
        return Gender.other;
      default:
        return Gender.other;
    }
  }
}
