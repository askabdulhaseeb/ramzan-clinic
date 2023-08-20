import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../database/apis/auth_api.dart';
import '../../database/apis/user_api.dart';
import '../../enums/registration_status.dart';
import '../../functions/picker_fun.dart';
import '../../models/user/app_user.dart';
import '../../utilities/custom_validator.dart';
import '../../utilities/utilities.dart';
import '../../widgets/custom/custom_circular_image.dart';
import '../../widgets/custom/custom_elevated_button.dart';
import '../../widgets/custom/custom_textformfield.dart';
import '../../widgets/custom/custom_toast.dart';
import '../../widgets/custom/password_textformfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  static const String routeName = '/signup';
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final TextEditingController _fillAddress = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool isLoading = false;
  File? file;
  Text statusText = Text('');
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
                const Text(
                  'Sign Up',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
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
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      const TextSpan(
                        text: 'Already have a account? ',
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextSpan(
                          text: 'Sign In',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).pop();
                            }),
                    ],
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onSignUp() async {
    if (!_key.currentState!.validate()) return;
    setState(() {
      isLoading = true;
    });
    final RegistrationStatus status = await UserAPI().canRegister(_email.text);
    if (status == RegistrationStatus.canRegister) {
      setState(() {
        statusText = const Text(
          'Registration Start, Please wait...',
          style: TextStyle(color: Colors.green),
        );
      });

      final AppUser? user =
          await AuthAPI().signUp(email: _email.text, password: _password.text);

      if (user == null) {
        if (!mounted) return;
        CustomToast.errorSnackBar(context: context, text: 'User Not Found');
      }
    } else if (status == RegistrationStatus.alreadyRegister) {
      setState(() {
        statusText = const Text(
          'You already registered, please Sign in',
          style: TextStyle(color: Colors.blue),
        );
      });
    } else if (status == RegistrationStatus.canNotRegister) {
      setState(() {
        statusText = const Text(
          '''You can't register yet, please contact admin''',
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
