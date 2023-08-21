import 'dart:io';

import 'package:firedart/firedart.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../enums/profile_state.dart';
import '../../models/user/app_user.dart';
import '../local/local_auth.dart';
import '../local/local_user.dart';

class UserAPI {
  final CollectionReference _collection =
      Firestore.instance.collection('users');

  Future<void> create(AppUser value) async {
    try {
      await _collection.document(value.uid).set(value.toMap());
      LocalUser().add(value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<AppUser?> user(String value) async {
    try {
      final Document doc = await _collection.document(value).get();
      final AppUser user = AppUser.fromMap(doc.map);
      LocalUser().add(user);
      return user;
    } catch (e) {
      return null;
    }
  }

  Future<ProfileState> canRegister(String email) async {
    try {
      final List<Document> doc =
          await _collection.where('email', isEqualTo: email.trim()).get();
      if (doc.isEmpty) return ProfileState.notExist;
      final AppUser user = AppUser.fromMap(doc[0].map);
      return user.isRegistered
          ? ProfileState.complate
          : ProfileState.readyToRegister;
    } catch (e) {
      return ProfileState.error;
    }
  }

  Future<String?> uploadProfilePhoto({required File file}) async {
    try {
      TaskSnapshot snapshot = await FirebaseStorage.instance
          .ref('profile_photos/${LocalAuth.uid}')
          .putFile(file);
      String url = await snapshot.ref.getDownloadURL();
      return url;
    } catch (e) {
      return null;
    }
  }
}
