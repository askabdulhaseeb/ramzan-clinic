import 'package:flutter/material.dart';

import '../../database/apis/auth_api.dart';
import '../../models/user/app_user.dart';
import '../../utilities/custom_validator.dart';
import '../../widgets/custom/custom_elevated_button.dart';
import '../../widgets/custom/custom_textformfield.dart';
import '../../widgets/custom/custom_toast.dart';
import '../../widgets/custom/password_textformfield.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Form(
          key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Sign In',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              CustomTextFormField(
                controller: _email,
                hint: 'Email',
                autoFocus: true,
                readOnly: isLoading,
                keyboardType: TextInputType.emailAddress,
                validator: (String? value) => CustomValidator.email(value),
              ),
              PasswordTextFormField(controller: _password),
              const SizedBox(height: 24),
              CustomElevatedButton(
                title: 'Sign In',
                isLoading: isLoading,
                onTap: onSignIn,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onSignIn() async {
    if (!_key.currentState!.validate()) return;
    setState(() {
      isLoading = true;
    });
    final AppUser? user =
        await AuthAPI().login(email: _email.text, password: _password.text);
    if (user == null) {
      if (!mounted) return;
      CustomToast.errorSnackBar(context: context, text: 'User Not Found');
      setState(() {
        isLoading = false;
      });
    }
    // Done
  }
}
