import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'basics.dart';
import 'database/local/local_auth.dart';
import 'database/local/local_db.dart';
import 'screens/auth/signin_screen.dart';
import 'screens/counter/create_counter_screen.dart';
import 'utilities/utilities.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDB.init();
  String apiKey = Utilities.apiKey;
  String projectID = Utilities.projectID;
  Firestore.initialize(projectID);
  FirebaseAuth.initialize(apiKey, VolatileStore());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: myProviders,
      child: MaterialApp(
        title: 'Ramzan Clinic',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: LocalAuth.uid.isEmpty
            ? const SignInScreen()
            : const CreateCounterScreen(),
        routes: myRoutes,
      ),
    );
  }
}

// Hive
// flutter packages pub run build_runner build
// Core 200...210
// Enum 211...220

// User 11...19
// User 21...29
// Test And Procigar 31...39
// Case 51...59
