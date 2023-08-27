class TimeFun {
  DateTime now() => DateTime.now();
  static DateTime parseTime(dynamic date) {
    return date == null
        ? DateTime.now()
        : DateTime.fromMillisecondsSinceEpoch(date.millisecondsSinceEpoch);
  }

  static String twoDigit(int num) =>
      num < 10 ? num.toString().padLeft(2, '0') : num.toString();
}
