import 'dart:io';
import 'package:flutter/material.dart';

import '../../database/apis/user_api.dart';
import '../../enums/profile_state.dart';
import '../../functions/picker_fun.dart';
import '../../utilities/custom_validator.dart';
import '../../utilities/utilities.dart';
import '../../widgets/custom/custom_appbar.dart';
import '../../widgets/custom/custom_circular_image.dart';
import '../../widgets/custom/custom_elevated_button.dart';
import '../../widgets/custom/custom_textformfield.dart';
import '../../widgets/custom/custom_toast.dart';
import '../../widgets/custom/password_textformfield.dart';

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
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final TextEditingController _fillAddress = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('+92'),
                      const SizedBox(width: 8),
                      Expanded(
                        child: CustomTextFormField(
                          controller: _phoneNumber,
                          hint: '3001234567',
                          readOnly: isLoading,
                          keyboardType: TextInputType.phone,
                          validator: (String? value) =>
                              CustomValidator.lengthLessThen(value, 11),
                        ),
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
                  hint: 'Confirm Password',
                ),
                const SizedBox(height: 8),
                statusText,
                CustomElevatedButton(
                  title: 'Sign In',
                  isLoading: isLoading,
                  onTap: onSignUp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addingMember() async {
    if (true) {
      if (!mounted) return;
      CustomToast.errorSnackBar(context: context, text: 'User Not Found');
    }
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
