import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/case_provider.dart';
import 'case_patient_display_widget.dart';
import 'case_prociger_widget.dart';

class CaseChooseableSideWidget extends StatelessWidget {
  const CaseChooseableSideWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CaseProvider>(
      builder: (BuildContext context, CaseProvider casePro, _) {
        return Column(
          children: <Widget>[
            const CasePatientDisplayWidget(),
            if (casePro.patient != null) const CaseProcigerWidget(),
          ],
        );
      },
    );
  }
}
