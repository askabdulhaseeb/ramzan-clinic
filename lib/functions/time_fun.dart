class TimeFun {
  DateTime now() => DateTime.now();
  static DateTime parseTime(dynamic value) {
    return value == null
        ? DateTime.now()
        : DateTime.fromMillisecondsSinceEpoch(value.millisecondsSinceEpoch);
  }

  static String dob(DateTime value) {
    return '${value.day}/${value.month}/${value.year}';
  }

  static String twoDigit(int num) =>
      num < 10 ? num.toString().padLeft(2, '0') : num.toString();
}
