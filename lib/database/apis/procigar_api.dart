import 'package:firedart/firedart.dart';
import 'package:flutter/widgets.dart';

import '../../models/procigar/procigar.dart';
import '../local/local_procigar.dart';

class ProcigarAPI {
  final CollectionReference _collection =
      Firestore.instance.collection('procigers');

  Future<bool> create(Procigar value) async {
    try {
      await _collection.document(value.testID).set(value.toMap());
      LocalProcigar().add(value);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<Procigar?> test(String value) async {
    try {
      final Document doc = await _collection.document(value).get();
      return Procigar.fromMap(doc.map);
    } catch (e) {
      return null;
    }
  }

  Future<void> loadAll() async {
    final List<Document> docs = await _collection.get();
    for (Document element in docs) {
      Procigar.fromMap(element.map);
    }
  }
}
