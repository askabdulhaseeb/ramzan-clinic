import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';

import '../../models/core/address.dart';
import '../local/local_address.dart';

class AddressAPI {
  final CollectionReference _collection =
      Firestore.instance.collection('addresses');

  Future<void> create(Address value) async {
    try {
      await _collection.document(value.addressID).set(value.toMap());
      LocalAddress().add(value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<Address?> address(String value) async {
    try {
      final Document doc = await _collection.document(value).get();
      return Address.fromMap(doc.map);
    } catch (e) {
      return null;
    }
  }

  Future<void> loadAll() async {
    final List<Document> docs = await _collection.get();
    for (Document element in docs) {
      Address.fromMap(element.map);
    }
  }
}
