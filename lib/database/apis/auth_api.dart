import 'package:firedart/auth/firebase_auth.dart';
import 'package:firedart/auth/user_gateway.dart';

import '../../models/user/app_user.dart';
import 'user_api.dart';

class AuthAPI {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<AppUser?> login({
    required String email,
    required String password,
  }) async {
    final User user = await _auth.signIn(email.trim(), password.trim());
    final AppUser? appUser = await UserAPI().user(user.id);
    return appUser;
  }
}
