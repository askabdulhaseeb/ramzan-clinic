import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';

import '../../models/case/counter.dart';
import '../local/local_auth.dart';

class CounterAPI {
  final CollectionReference _collection =
      Firestore.instance.collection('counters');

  Future<void> create(Counter value) async {
    try {
      await _collection.document(value.counterID).set(value.toMap());
      value.isLive = true;
    } catch (e) {
      value.isLive = false;
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

  Future<void> update(Counter value) async {
    try {
      await _collection.document(value.counterID).update(value.updateMap());
    } catch (e) {
      return;
    }
  }

  Future<List<Counter>> openCounters() async {
    List<Counter> results = <Counter>[];
    try {
      final List<Document> docs =
          await _collection.where('is_opened', isEqualTo: true).get();
      for (Document element in docs) {
        results.add(Counter.fromMap(element.map));
      }
    } catch (e) {
      return results;
    }
    return results;
  }

  Future<Counter?> myCounter() async {
    List<Counter> results = <Counter>[];
    try {
      final List<Document> docs = await _collection
          .where('is_opened', isEqualTo: true)
          .where('uid', isEqualTo: LocalAuth.uid)
          .get();
      for (Document element in docs) {
        results.add(Counter.fromMap(element.map));
      }
      return results.isEmpty ? null : results[0];
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
