import '../../functions/id_generator.dart';
import '../../functions/time_fun.dart';

class Address {
  Address({
    required this.province,
    required this.district,
    required this.city,
    required this.town,
    String? addressID,
    String? country,
    DateTime? registerDate,
    DateTime? lastUpdate,
  })  : addressID = addressID ?? IdGenerator.address(city),
        country = country ?? 'Pakistan',
        registerDate = registerDate ?? DateTime.now(),
        lastUpdate = lastUpdate ?? DateTime.now();

  final String addressID;
  final String country;
  final String province;
  final String district;
  final String city;
  final String town;
  final DateTime registerDate;
  final DateTime lastUpdate;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address_id': addressID,
      'country': country,
      'province': province,
      'district': district,
      'city': city,
      'town': town,
      'register_date': registerDate,
      'last_update': lastUpdate,
    };
  }

  // ignore: sort_constructors_first
  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      addressID: map['address_id'] ?? '',
      country: map['country'] ?? '',
      province: map['province'] ?? '',
      district: map['district'] ?? '',
      city: map['city'] ?? '',
      town: map['town'] ?? '',
      registerDate: TimeFun.parseTime(map['register_date']),
      lastUpdate: TimeFun.parseTime(map['last_update']),
    );
  }
}
