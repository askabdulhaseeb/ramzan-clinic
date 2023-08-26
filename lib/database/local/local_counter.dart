import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/case/counter.dart';
import '../apis/counter_api.dart';

class LocalCounter {
  static const String boxTitle = 'counter';
  static Future<Box<Counter>> get openBox async =>
      await Hive.openBox<Counter>(boxTitle);

  static Future<void> get closeBox async => Hive.box<Counter>(boxTitle).close();
  static Box<Counter> get _box => Hive.box<Counter>(boxTitle);

  Future<Box<Counter>> refresh() async {
    final bool isOpen = Hive.box<Counter>(boxTitle).isOpen;
    if (isOpen) {
      return _box;
    } else {
      return await Hive.openBox<Counter>(boxTitle);
    }
  }

  Future<void> add(Counter value) async {
    try {
      if (_box.isEmpty) {
        await _box.put(value.counterID, value);
      } else {
        await CounterAPI().create(counter());
        _box.clear();
        add(value);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Counter counter() {
    final Counter? user = _box.getAt(0);
    return user ?? _null;
  }

  Counter get _null => Counter(
        counterID: '',
        uid: '',
        counterCases: 0,
        dayCases: 0,
        openingCash: 0,
        cashInCounter: 0,
        isOpened: false,
        openingTime: DateTime.now(),
        closingTime: DateTime.now(),
      );
}
