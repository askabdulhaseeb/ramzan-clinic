import 'package:firedart/firedart.dart';

import '../../models/core/address.dart';

class AddressAPI {
  final CollectionReference _collection =
      Firestore.instance.collection('addresses');

  Future<void> create(Address value) async {
    await _collection.document(value.addressID).set(value.toMap());
  }

  Future<Address?> address(String value) async {
    try {
      final Document doc = await _collection.document(value).get();
      return Address.fromMap(doc.map);
    } catch (e) {
      return null;
    }
  }
}
