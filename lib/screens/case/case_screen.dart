import 'package:flutter/material.dart';

class CaseScreen extends StatelessWidget {
  const CaseScreen({Key? key}) : super(key: key);
  static const String routeName = '/case';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CaseScreen'),
      ),
      body: const Center(child: Text('CaseScreen')),
    );
  }
}
