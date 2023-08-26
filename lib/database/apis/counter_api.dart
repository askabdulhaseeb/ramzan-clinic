import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';

import '../../models/case/counter.dart';
import '../local/local_counter.dart';

class CounterAPI {
  final CollectionReference _collection =
      Firestore.instance.collection('counters');

  Future<void> create(Counter value) async {
    try {
      await _collection.document(value.counterID).set(value.toMap());
      LocalCounter().add(value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<Counter?> counter(String value) async {
    try {
      final Document doc = await _collection.document(value).get();
      return Counter.fromMap(doc.map);
    } catch (e) {
      return null;
    }
  }

  Future<void> loadAll() async {
    final List<Document> docs = await _collection.get();
    for (Document element in docs) {
      Counter.fromMap(element.map);
    }
  }
}
