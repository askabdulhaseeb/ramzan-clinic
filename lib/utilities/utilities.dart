import 'dart:io';

import 'package:flutter/material.dart';

class Utilities {
  static double get maxWidth =>
      Platform.isAndroid || Platform.isIOS ? double.infinity : 300;
  static String get apiKey => 'AIzaSyC0QkIkT5Fgxdz-EbNKuoK1BWuoFj7AhBU';
  static String get projectID => 'ramzan-clinic';
  IconData status(bool isLive) =>
      isLive ? Icons.cloud_done_outlined : Icons.laptop;
}
