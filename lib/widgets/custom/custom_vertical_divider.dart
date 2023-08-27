import 'package:flutter/material.dart';

class CustomVerticalDivider extends StatelessWidget {
  const CustomVerticalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 28,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      color: Colors.grey,
    );
  }
}
