import 'package:firedart/firedart.dart';

import '../../models/user/app_user.dart';

class UserAPI {
  final CollectionReference _collection =
      Firestore.instance.collection('users');

  Future<void> create(AppUser value) async {
    await _collection.document(value.uid).set(value.toMap());
  }

  Future<AppUser?> user(String value) async {
    try {
      final Document doc = await _collection.document(value).get();
      return AppUser.fromMap(doc.map);
    } catch (e) {
      return null;
    }
  }
}
