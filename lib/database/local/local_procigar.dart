import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../enums/procigar_type.dart';
import '../../models/procigar/procigar.dart';
import '../apis/procigar_api.dart';

class LocalProcigar {
  static const String boxTitle = 'procigars';
  static Future<Box<Procigar>> get openBox async =>
      await Hive.openBox<Procigar>(boxTitle);

  static Future<void> get closeBox async =>
      Hive.box<Procigar>(boxTitle).close();
  static Box<Procigar> get _box => Hive.box<Procigar>(boxTitle);

  Future<Box<Procigar>> refresh() async {
    final bool isOpen = Hive.box<Procigar>(boxTitle).isOpen;
    if (isOpen) {
      return _box;
    } else {
      return await Hive.openBox<Procigar>(boxTitle);
    }
  }

  void add(Procigar value) async {
    try {
      await _box.put(value.testID, value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<Procigar> procigar(String id) async {
    final Procigar? user = _box.get(id);
    return user ?? await _load(id);
  }

  List<Procigar> searchProcigar(String value) {
    return _box.values
        .where((Procigar element) =>
            element.name.toLowerCase().contains(value.toLowerCase()))
        .toList();
  }

  Future<Procigar> _load(String id) async {
    return await ProcigarAPI().test(id) ?? _null;
  }

  Procigar get _null => Procigar(
        name: 'null',
        fee: 0,
        discountInPercent: 0,
        type: ProcigarType.test,
      );
}
