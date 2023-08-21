import 'package:flutter/material.dart';

import '../../database/apis/department_api.dart';
import '../../models/core/department.dart';
import '../../utilities/custom_validator.dart';
import '../../widgets/custom/custom_appbar.dart';
import '../../widgets/custom/custom_elevated_button.dart';
import '../../widgets/custom/custom_textformfield.dart';
import '../../widgets/custom/custom_toast.dart';

class AddDepartmentScreen extends StatefulWidget {
  const AddDepartmentScreen({Key? key}) : super(key: key);
  static const String routeName = '/add-department';

  @override
  State<AddDepartmentScreen> createState() => _AddDepartmentScreenState();
}

class _AddDepartmentScreenState extends State<AddDepartmentScreen> {
  final TextEditingController title = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Form(
          key: key,
          child: Column(
            children: <Widget>[
              const CustomAppBar(title: 'Add Department'),
              CustomTextFormField(
                controller: title,
                autoFocus: true,
                hint: 'Title: Ex. Doctor, Helper, Worker',
                textCapitalization: TextCapitalization.words,
                validator: (String? value) => CustomValidator.lessThen5(value),
              ),
              CustomElevatedButton(
                title: 'Save',
                isLoading: isLoading,
                onTap: onTap,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onTap() async {
    if (!key.currentState!.validate()) return;
    try {
      setState(() {
        isLoading = true;
      });
      final Department department = Department(title: title.text);
      await DepartmentAPI().create(department);
      title.clear();
    } catch (e) {
      debugPrint(e.toString());
      CustomToast.errorSnackBar(
        context: context,
        text: 'Something wents wrong - ${e.toString()}',
      );
    }
    setState(() {
      isLoading = false;
    });
  }
}
