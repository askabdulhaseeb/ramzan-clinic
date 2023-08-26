import 'package:flutter/widgets.dart';

import 'screens/address/add_address_screen.dart';
import 'screens/auth/signin_screen.dart';
import 'screens/case/case_screen.dart';
import 'screens/department/add_department_screen.dart';
import 'screens/user/add_user_screen.dart';
import 'screens/bashboard/dashboard_screen.dart';

final Map<String, WidgetBuilder> myRoutes = <String, WidgetBuilder>{
  SignInScreen.routeName: (_) => const SignInScreen(),
  // DASHBOARD
  DashboardScreen.routeName: (_) => const DashboardScreen(),
  // USERS
  AddUserScreen.routeName: (_) => const AddUserScreen(),
  // ADDRESS
  AddAddressScreen.routeName: (_) => const AddAddressScreen(),
  // DEPARTMENT
  AddDepartmentScreen.routeName: (_) => const AddDepartmentScreen(),
  // PROCIGAR
  // CASE
  CaseScreen.routeName: (_) => const CaseScreen(),
};
