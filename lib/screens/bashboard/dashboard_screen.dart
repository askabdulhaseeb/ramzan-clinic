import 'package:flutter/material.dart';

import '../../database/apis/auth_api.dart';
import '../user/add_user_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  static const String routeName = '/dashboard';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DashboardScreen'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(AddUserScreen.routeName),
              child: const Text('Add User'),
            ),
            TextButton(
              onPressed: () => AuthAPI().signOut(),
              child: const Text('Signout'),
            ),
          ],
        ),
      ),
    );
  }
}
