import 'package:firedart/auth/firebase_auth.dart';
import 'package:firedart/auth/user_gateway.dart';
import 'package:flutter/material.dart';

import '../../functions/my_internet.dart';
import '../../models/user/app_user.dart';
import '../local/local_auth.dart';
import '../local/local_user.dart';
import 'user_api.dart';

class AuthAPI {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static String get uid => _auth.userId;
  static Future<User?> get name => _auth.getUser();

  Stream<bool> get signInState => _auth.signInState;
  bool get isSignIn => _auth.isSignedIn;

  Future<AppUser?> login({
    required String email,
    required String password,
  }) async {
    try {
      final bool isConnected = await MyInternet().isConnected();
      if (isConnected) {
        final User user = await _auth.signIn(email.trim(), password.trim());
        final AppUser? appUser = await UserAPI().user(user.id);
        if (appUser != null) {
          LocalAuth().setCurrentUser(appUser);
        }
        return appUser;
      } else {
        final AppUser? user =
            await LocalUser().login(email: email, password: password);
        print(user?.uid);
        if (user == null) throw ('Invalid');
        LocalAuth().setCurrentUser(user);
        return user;
      }
    } catch (e) {
      debugPrint('$email & $password - $e');
      return null;
    }
  }

  Future<AppUser?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final User user = await _auth.signIn(email.trim(), password.trim());
      final AppUser? appUser = await UserAPI().user(user.id);
      return appUser;
    } catch (e) {
      return null;
    }
  }

  Future<void> updateNameAndPhoto(String name, String url) async {
    await _auth.updateProfile(displayName: name, photoUrl: url);
  }

  void signOut() {
    _auth.signOut();
    LocalAuth().signOut();
  }
}
