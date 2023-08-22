import 'dart:developer';

import 'package:flutter/material.dart';

import '../../database/apis/address_api.dart';
import '../../database/apis/auth_api.dart';
import '../../database/apis/department_api.dart';
import '../../database/apis/user_api.dart';
import '../address/add_address_screen.dart';
import '../department/add_department_screen.dart';
import '../user/add_user_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  static const String routeName = '/dashboard';

  _init() async {
    await UserAPI().loadAll();
    await AddressAPI().loadAll();
    await DepartmentAPI().loadAll();
    log('init load Complete');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DashboardScreen'),
      ),
      body: FutureBuilder<void>(
        future: _init(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          return Center(
            child: Column(
              children: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamed(AddAddressScreen.routeName),
                  child: const Text('Add Address'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamed(AddDepartmentScreen.routeName),
                  child: const Text('Add Department'),
                ),
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
          );
        },
      ),
    );
  }
}
