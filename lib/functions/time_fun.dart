import 'package:cloud_firestore/cloud_firestore.dart';

class TimeFun {
  DateTime now() => DateTime.now();
  static DateTime parseTime(dynamic date) {
    return date == null ? DateTime.now() : (date as Timestamp).toDate();
  }

  static String twoDigit(int num) =>
      num < 10 ? num.toString().padLeft(2, '0') : num.toString();
}
