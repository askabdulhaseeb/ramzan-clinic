import 'package:flutter/widgets.dart';

import 'screens/auth/signin_screen.dart';
import 'screens/auth/signup_screen.dart';

final Map<String, WidgetBuilder> myRoutes = <String, WidgetBuilder>{
  SignInScreen.routeName: (_) => const SignInScreen(),
  SignUpScreen.routeName: (_) => const SignUpScreen(),
};
