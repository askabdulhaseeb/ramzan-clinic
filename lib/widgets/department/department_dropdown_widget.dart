import 'package:flutter/material.dart';

import '../../database/local/local_department.dart';
import '../../models/core/department.dart';

class DepartmentDropdownWidget extends StatefulWidget {
  const DepartmentDropdownWidget({
    required this.onChanged,
    this.selectedDepartment,
    super.key,
  });
  final Department? selectedDepartment;
  final void Function(Department) onChanged;

  @override
  State<DepartmentDropdownWidget> createState() =>
      _DepartmentDropdownWidgetState();
}

class _DepartmentDropdownWidgetState extends State<DepartmentDropdownWidget> {
  late List<Department> departments;
  Department? selectedDepartment;
  @override
  void initState() {
    departments = LocalDepartment().departments();
    selectedDepartment = widget.selectedDepartment;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).textTheme.bodySmall!.color!,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: DropdownButton<Department>(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        value: selectedDepartment,
        hint: const Text('Department', style: TextStyle(color: Colors.grey)),
        underline: const SizedBox(),
        isExpanded: true,
        items: departments
            .map((Department e) =>
                DropdownMenuItem<Department>(value: e, child: Text(e.title)))
            .toList(),
        onChanged: (Department? value) {
          if (value == null) return;
          setState(() {
            selectedDepartment = value;
          });
          widget.onChanged(value);
        },
      ),
    );
  }
}
