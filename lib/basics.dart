import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'provider/case_provider.dart';
import 'screens/address/add_address_screen.dart';
import 'screens/auth/signin_screen.dart';
import 'screens/case/case_screen.dart';
import 'screens/counter/create_counter_screen.dart';
import 'screens/department/add_department_screen.dart';
import 'screens/patient/add_patient_screen.dart';
import 'screens/user/add_user_screen.dart';
import 'screens/bashboard/dashboard_screen.dart';

final List<SingleChildWidget> myProviders = <SingleChildWidget>[
  ChangeNotifierProvider<CaseProvider>(
      create: (BuildContext context) => CaseProvider()),
];

final Map<String, WidgetBuilder> myRoutes = <String, WidgetBuilder>{
  SignInScreen.routeName: (_) => const SignInScreen(),
  // COUNTER
  CreateCounterScreen.routeName: (_) => const CreateCounterScreen(),
  // DASHBOARD
  DashboardScreen.routeName: (_) => const DashboardScreen(),
  // USERS
  AddUserScreen.routeName: (_) => const AddUserScreen(),
  // ADDRESS
  AddAddressScreen.routeName: (_) => const AddAddressScreen(),
  // DEPARTMENT
  AddDepartmentScreen.routeName: (_) => const AddDepartmentScreen(),
  // PROCIGAR
  // PATIENT
  AddPatientScreen.routeName: (_) => const AddPatientScreen(),
  // CASE
  CaseScreen.routeName: (_) => const CaseScreen(),
};
