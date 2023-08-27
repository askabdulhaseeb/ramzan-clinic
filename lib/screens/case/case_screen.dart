import 'package:flutter/material.dart';

import '../../database/apis/auth_api.dart';
import '../../widgets/case/case_app_bar.dart';
import '../../widgets/case/case_patient_display_widget.dart';
import '../../widgets/custom/custom_vertical_divider.dart';

class CaseScreen extends StatelessWidget {
  const CaseScreen({Key? key}) : super(key: key);
  static const String routeName = '/case';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const CaseAppBar(),
        actions: <Widget>[
          const CustomVerticalDivider(),
          TextButton.icon(
            onPressed: () {},
            label: const Text('Patients'),
            icon: const Icon(Icons.co_present_outlined),
          ),
          const CustomVerticalDivider(),
          TextButton.icon(
            onPressed: () {},
            label: const Text('Cases'),
            icon: const Icon(Icons.camera_front_outlined),
          ),
          const CustomVerticalDivider(),
          TextButton.icon(
            onPressed: () {},
            label: const Text('Drawer'),
            icon: const Icon(Icons.calculate_outlined),
          ),
          const CustomVerticalDivider(),
          TextButton.icon(
            onPressed: () => AuthAPI().signOut(),
            label: const Text('Logout'),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          const Text(
            'Ramzan Clinic',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Container(),
                const CasePatientDisplayWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
