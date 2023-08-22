import 'package:hive_flutter/hive_flutter.dart';
part 'procigar_type.g.dart';

@HiveType(typeId: 32)
enum ProcigarType {
  @HiveField(0)
  test('Test', 'test'),
  @HiveField(1)
  procigar('Procigar', 'procigar');

  const ProcigarType(this.title, this.json);
  final String title;
  final String json;
}

class ProcigarTypeFun {
  static ProcigarType fromJson(String expression) {
    switch (expression) {
      case 'test':
        return ProcigarType.test;
      case 'procigar':
        return ProcigarType.procigar;
      default:
        return ProcigarType.test;
    }
  }
}
