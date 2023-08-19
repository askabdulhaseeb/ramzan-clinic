import 'dart:math';

class IdGenerator {
  static String patientID(String name) {
    return '${placeholder(name).toLowerCase()}${generateRandomString(length: 6)}';
  }

  static String department(String title) {
    return '${_trim(title)}-${generateRandomString(length: 3)}';
  }

  static String address(String city) {
    return '${_trim(city)}-${generateRandomString(length: 3)}';
  }

  static String generateRandomString({int length = 6}) {
    const String letterLowerCase = 'abcdefghijklmnopqrstuvwxyz';
    const String letterUpperCase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    // don't user 0, it confuse users sometimes with 'o' and 'O'
    const String number = '123456789';
    const String possibleChar = letterLowerCase +
        // AuthMethods.uid +
        letterUpperCase +
        number;
    return List<String>.generate(length, (int index) {
      final int indexRandom = Random.secure().nextInt(possibleChar.length);
      return possibleChar[indexRandom];
    }).join('').trim();
  }

  static String placeholder(String value) {
    value.trim();
    String temp = value[0];
    value.contains(' ')
        ? temp += value[value.lastIndexOf(' ') + 1]
        : temp += value[1];
    return temp;
  }

  static String _trim(String value) =>
      value.trim().toLowerCase().substring(0, value.indexOf(' '));
}