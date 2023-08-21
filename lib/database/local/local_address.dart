import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/core/address.dart';
import '../apis/address_api.dart';

class LocalAddress {
  static const String boxTitle = 'addresses';
  static Future<Box<Address>> get openBox async =>
      await Hive.openBox<Address>(boxTitle);

  static Future<void> get closeBox async => Hive.box<Address>(boxTitle).close();
  static Box<Address> get _box => Hive.box<Address>(boxTitle);

  Future<Box<Address>> refresh() async {
    final bool isOpen = Hive.box<Address>(boxTitle).isOpen;
    if (isOpen) {
      return _box;
    } else {
      return await Hive.openBox<Address>(boxTitle);
    }
  }

  void add(Address value) async {
    try {
      await _box.put(value.addressID, value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<Address> address(String id) async {
    final Address? user = _box.get(id);
    return user ?? await _load(id);
  }

  List<Address> searchAddress(String value) {
    return _box.values
        .where((Address element) =>
            element.string.toLowerCase().contains(value.toLowerCase()))
        .toList();
  }

  Future<Address> _load(String id) async {
    return await AddressAPI().address(id) ?? _null;
  }

  Address get _null => Address(
        province: 'null',
        district: 'null',
        city: 'null',
        town: 'null',
      );
}
