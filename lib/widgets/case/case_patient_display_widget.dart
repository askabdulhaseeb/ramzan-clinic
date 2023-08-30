import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database/local/local_patient.dart';
import '../../models/patient/patient.dart';
import '../../provider/case_provider.dart';
import '../../screens/patient/add_patient_screen.dart';

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
    return Flexible(
      child: Container(
        width: 240,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Provider.of<CaseProvider>(context).patient == null
            ? SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 8),
                    CupertinoSearchTextField(
                      placeholder: 'Name/CNIC/Phone',
                      onChanged: (String value) => setState(() {
                        search = value;
                      }),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      leading: const Icon(Icons.add),
                      title: const Text('Add Patient'),
                      visualDensity: const VisualDensity(vertical: -4),
                      subtitle: const Text(
                        'If not register already',
                        style: TextStyle(color: Colors.grey),
                      ),
                      onTap: () => Navigator.of(context)
                          .pushNamed(AddPatientScreen.routeName),
                    ),
                    const Divider(height: 2),
                    const Divider(height: 2),
                    ListView.separated(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: patients.length,
                      separatorBuilder: (_, __) => const Divider(height: 0),
                      itemBuilder: (BuildContext context, int index) {
                        final Patient patient = patients[index];
                        return ListTile(
                          onTap: () =>
                              Provider.of<CaseProvider>(context, listen: false)
                                  .onPatientUpdate(patient),
                          title: Text('${patient.name}\n${patient.lastName}'),
                          subtitle: Text(
                            '${patient.ecryptedPhoneNumber}\n${patient.fullAddress}',
                          ),
                          isThreeLine: true,
                        );
                      },
                    ),
                  ],
                ),
              )
            : ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: Text(
                  Provider.of<CaseProvider>(context).patient?.name ?? 'null',
                ),
                subtitle: Text(
                  Provider.of<CaseProvider>(context).patient?.lastName ??
                      'null',
                ),
                trailing: InkWell(
                  onTap: () =>
                      Provider.of<CaseProvider>(context, listen: false).reset(),
                  child: const Icon(Icons.delete, color: Colors.red),
                ),
              ),
      ),
    );
  }
}
