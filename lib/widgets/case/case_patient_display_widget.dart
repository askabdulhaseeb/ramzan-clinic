import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../database/local/local_patient.dart';
import '../../models/patient/patient.dart';

class CasePatientDisplayWidget extends StatefulWidget {
  const CasePatientDisplayWidget({super.key});

  @override
  State<CasePatientDisplayWidget> createState() =>
      _CasePatientDisplayWidgetState();
}

class _CasePatientDisplayWidgetState extends State<CasePatientDisplayWidget> {
  String search = '';
  @override
  Widget build(BuildContext context) {
    final List<Patient> patients = LocalPatient().search(search);
    return Container(
      width: 240,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 8),
          CupertinoSearchTextField(
            placeholder: 'Name/CNIC/Phone',
            onChanged: (String value) => setState(() {
              search = value;
            }),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: patients.length,
              itemBuilder: (BuildContext context, int index) {
                final Patient patient = patients[index];
                return ListTile(
                  title: Text('${patient.name} ${patient.lastName}'),
                  subtitle: Text(patient.phoneNumber),
                );
              },
            ),
          ),
          const Divider(height: 2),
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            leading: const Icon(Icons.add),
            title: const Text('Add Patient'),
            visualDensity: const VisualDensity(vertical: -4),
            subtitle: const Text(
              'If not register already',
              style: TextStyle(color: Colors.grey),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
