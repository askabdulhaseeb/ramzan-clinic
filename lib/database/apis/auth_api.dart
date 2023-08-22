import 'package:firedart/auth/firebase_auth.dart';
import 'package:firedart/auth/user_gateway.dart';
import 'package:flutter/material.dart';

import '../../models/user/app_user.dart';
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
      final User user = await _auth.signIn(email.trim(), password.trim());
      final AppUser? appUser = await UserAPI().user(user.id);
      return appUser;
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

  void signOut() => _auth.signOut();
}
