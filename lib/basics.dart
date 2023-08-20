import 'package:flutter/widgets.dart';

import 'screens/auth/signin_screen.dart';
import 'screens/user/add_user_screen.dart';
import 'screens/bashboard/dashboard_screen.dart';

final Map<String, WidgetBuilder> myRoutes = <String, WidgetBuilder>{
  SignInScreen.routeName: (_) => const SignInScreen(),
  // DASHBOARD
  DashboardScreen.routeName: (_) => const DashboardScreen(),
  // USERS
  AddUserScreen.routeName: (_) => const AddUserScreen(),
};
