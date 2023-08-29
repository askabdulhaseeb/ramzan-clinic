import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database/local/local_department.dart';
import '../../database/local/local_user.dart';
import '../../models/core/department.dart';
import '../../models/user/app_user.dart';
import '../../provider/case_provider.dart';
import '../custom/custom_vertical_divider.dart';

class CaseAppBar extends StatelessWidget {
  const CaseAppBar({super.key});

  @override
  Widget build(BuildContext context) {
      final List<Department> departments = LocalDepartment().departments();
    return Consumer<CaseProvider>(
        builder: (BuildContext context, CaseProvider casePro, _) {
      final List<AppUser> doctor = LocalUser().userByDepartment(
          departments.isEmpty ? null : casePro.department?.departmentID);
      return Row(
        children: <Widget>[
          DropdownButton<Department>(
            hint: const Text(' Department'),
            items: departments
                .map((Department e) => DropdownMenuItem<Department>(
                      value: e,
                      child: Text(e.title),
                    ))
                .toList(),
            borderRadius: BorderRadius.circular(10),
            value: departments.isEmpty ? null : casePro.department,
            underline: const SizedBox(),
            onChanged: (Department? value) => casePro.onDepartmentUpdate(value),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: CustomVerticalDivider(),
          ),
          DropdownButton<AppUser>(
            hint: const Text(' Doctor'),
            items: doctor
                .map((AppUser e) => DropdownMenuItem<AppUser>(
                      value: e,
                      child: Text(e.name),
                    ))
                .toList(),
            borderRadius: BorderRadius.circular(10),
            value: casePro.doctor,
            underline: const SizedBox(),
            onChanged: (AppUser? value) => casePro.onDoctorUpdate(value),
          ),
        ],
      );
    });
  }
}
