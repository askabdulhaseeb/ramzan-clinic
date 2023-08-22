import 'dart:io';
import 'package:flutter/material.dart';

import '../../database/apis/user_api.dart';
import '../../enums/profile_state.dart';
import '../../functions/id_generator.dart';
import '../../functions/picker_fun.dart';
import '../../models/core/department.dart';
import '../../models/user/app_user.dart';
import '../../utilities/custom_validator.dart';
import '../../utilities/utilities.dart';
import '../../widgets/custom/custom_appbar.dart';
import '../../widgets/custom/custom_circular_image.dart';
import '../../widgets/custom/custom_elevated_button.dart';
import '../../widgets/custom/custom_textformfield.dart';
import '../../widgets/custom/custom_toast.dart';
import '../../widgets/custom/password_textformfield.dart';
import '../../widgets/department/department_dropdown_widget.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({Key? key}) : super(key: key);
  static const String routeName = '/add-user';
  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _fillAddress = TextEditingController();
  final TextEditingController _job = TextEditingController();
  final TextEditingController _salary = TextEditingController();

  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  Department? selectedDepartment;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  List<String> phoneNumbers = <String>[];
  bool isLoading = false;
  File? file;
  Text statusText = const Text('');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Form(
          key: _key,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const CustomAppBar(title: 'Add User'),
                const SizedBox(height: 32),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: <Widget>[
                    CustomCircularImage(file: file, radius: 48),
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.grey.withOpacity(0.3),
                      child: IconButton(
                        onPressed: () async {
                          final File? result = await PickerFun().image();
                          if (result == null) return;
                          file = result;
                        },
                        icon: const Icon(
                          Icons.camera_alt,
                          size: 16,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  controller: _name,
                  autoFocus: true,
                  hint: 'Full Name',
                  textCapitalization: TextCapitalization.words,
                  validator: (String? value) =>
                      CustomValidator.lessThen3(value),
                ),
                CustomTextFormField(
                  controller: _email,
                  hint: 'Email',
                  readOnly: isLoading,
                  keyboardType: TextInputType.emailAddress,
                  validator: (String? value) => CustomValidator.email(value),
                ),
                SizedBox(
                  width: Utilities.maxWidth,
                  child: Row(
                    children: <Widget>[
                      const Text('Department'),
                      const SizedBox(width: 10),
                      Expanded(
                        child: DepartmentDropdownWidget(
                          selectedDepartment: selectedDepartment,
                          onChanged: (Department value) {
                            selectedDepartment = value;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                CustomTextFormField(
                  controller: _job,
                  hint: 'Job Description',
                  textCapitalization: TextCapitalization.sentences,
                  validator: (String? value) => null,
                ),
                CustomTextFormField(
                  controller: _salary,
                  hint: 'Salary',
                  keyboardType: TextInputType.number,
                  validator: (String? value) => null,
                ),
                Container(
                  width: Utilities.maxWidth,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(width: 4),
                          const Text('+92'),
                          const SizedBox(width: 8),
                          Expanded(
                            child: CustomTextFormField(
                              controller: _phoneNumber,
                              hint: '3001234567',
                              readOnly: isLoading,
                              keyboardType: TextInputType.phone,
                              validator: (String? value) =>
                                  phoneNumbers.isEmpty ? 'Add Number' : null,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              final String number =
                                  '+92${_phoneNumber.text.trim()}';
                              if (!phoneNumbers.contains(number)) {
                                phoneNumbers.add(number);
                                _phoneNumber.clear();
                              }
                              setState(() {});
                            },
                            icon: const Icon(Icons.done),
                          ),
                        ],
                      ),
                      Wrap(
                        children: phoneNumbers
                            .map((String e) => Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 8),
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      const SizedBox(width: 6),
                                      Text(e),
                                      IconButton(
                                        onPressed: () => setState(() {
                                          phoneNumbers.remove(e);
                                        }),
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      )
                                    ],
                                  ),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
                CustomTextFormField(
                  controller: _fillAddress,
                  hint: 'Full Address',
                  readOnly: isLoading,
                  keyboardType: TextInputType.streetAddress,
                  validator: (String? value) =>
                      CustomValidator.lessThen5(value),
                ),
                PasswordTextFormField(controller: _password),
                PasswordTextFormField(
                  controller: _confirmPassword,
                  validator: (String? value) =>
                      _password.text == value ? null : 'Password Not Match',
                  hint: 'Confirm Password',
                ),
                const SizedBox(height: 8),
                statusText,
                CustomElevatedButton(
                  title: 'Sign In',
                  isLoading: isLoading,
                  onTap: onSignUp,
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addingMember() async {
    if (selectedDepartment == null) {
      CustomToast.errorSnackBar(context: context, text: 'Select Department');
      return;
    }
    String url = '';
    if (file != null) {
      url = await UserAPI().uploadProfilePhoto(file: file!) ?? '';
    }
    final AppUser user = AppUser(
      uid: IdGenerator.dummyUser(_email.text),
      name: _name.text,
      email: _email.text,
      imageURL: url,
      departmentID: selectedDepartment?.departmentID ?? '',
      phoneNumber: phoneNumbers,
      jobDescription: _job.text,
      salary: double.tryParse(_salary.text) ?? 0.0,
      fullAddress: _fillAddress.text,
      isRegistered: false,
      password: _password.text,
    );
    final bool added = await UserAPI().create(user);
    if (!mounted) return;
    if (added) {
      CustomToast.successSnackBar(
          context: context, text: '${_name.text} Added');
      _reset();
    } else {
      CustomToast.errorSnackBar(context: context, text: 'User Already Exist');
    }
  }

  _reset() {
    _name.clear();
    _email.clear();
    file = null;
    selectedDepartment = null;
    phoneNumbers.clear();
    _job.clear();
    _salary.clear();
    _fillAddress.clear();
    _password.clear();
    _confirmPassword.clear();
    statusText = const Text('');
    setState(() {});
  }

  Future<void> onSignUp() async {
    if (!_key.currentState!.validate()) return;
    setState(() {
      isLoading = true;
    });
    final ProfileState status = await UserAPI().canRegister(_email.text);
    if (status == ProfileState.notExist) {
      setState(() {
        statusText = const Text(
          'Registration Start, Please wait...',
          style: TextStyle(color: Colors.green),
        );
      });
      await addingMember();
    } else if (status == ProfileState.readyToRegister) {
      setState(() {
        statusText = const Text(
          'You already registered, please Sign in',
          style: TextStyle(color: Colors.blue),
        );
      });
    } else if (status == ProfileState.complate) {
      setState(() {
        statusText = const Text(
          '''You can't register''',
          style: TextStyle(color: Colors.green),
        );
      });
    } else {
      setState(() {
        statusText = const Text(
          '''Something goes wrong, try again''',
          style: TextStyle(color: Colors.red),
        );
      });
    }
    setState(() {
      isLoading = false;
    });
  }
}
