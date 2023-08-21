import 'package:hive/hive.dart';

import '../../database/apis/auth_api.dart';
import '../../database/local/local_address.dart';
import '../../functions/id_generator.dart';
import '../../functions/time_fun.dart';
part 'address.g.dart';

@HiveType(typeId: 200)
class Address extends HiveObject {
  Address({
    required this.province,
    required this.district,
    required this.city,
    required this.town,
    String? string,
    String? addBy,
    String? addressID,
    String? country,
    DateTime? registerDate,
    DateTime? lastUpdate,
  })  : addressID = addressID ?? IdGenerator.address(town),
        country = country ?? 'Pakistan',
        string = string ?? '$town, $city, $district, $province, $country',
        addBy = addBy ?? AuthAPI.uid,
        registerDate = registerDate ?? DateTime.now(),
        lastUpdate = lastUpdate ?? DateTime.now();

  @HiveField(0, defaultValue: 'null')
  final String addressID;
  @HiveField(1, defaultValue: 'null')
  final String country;
  @HiveField(2, defaultValue: 'null')
  final String province;
  @HiveField(3, defaultValue: 'null')
  final String district;
  @HiveField(4, defaultValue: 'null')
  final String city;
  @HiveField(5, defaultValue: 'null')
  final String town;
  @HiveField(6, defaultValue: null)
  final DateTime registerDate;
  @HiveField(7, defaultValue: null)
  final DateTime lastUpdate;
  @HiveField(8, defaultValue: 'null')
  final String addBy;
  @HiveField(9, defaultValue: 'null')
  final String string;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address_id': addressID,
      'country': country.trim(),
      'province': province.trim(),
      'district': district.trim(),
      'city': city.trim(),
      'town': town.trim(),
      'string': string,
      'add_by': addBy,
      'register_date': registerDate,
      'last_update': lastUpdate,
    };
  }

  // ignore: sort_constructors_first
  factory Address.fromMap(Map<String, dynamic> map) {
    final Address address = Address(
      addressID: map['address_id'] ?? '',
      country: map['country'] ?? '',
      province: map['province'] ?? '',
      district: map['district'] ?? '',
      city: map['city'] ?? '',
      town: map['town'] ?? '',
      string: map['string'] ?? '',
      addBy: map['add_by'] ?? '',
      registerDate: TimeFun.parseTime(map['register_date']),
      lastUpdate: TimeFun.parseTime(map['last_update']),
    );
    LocalAddress().add(address);
    return address;
  }

  @override
  String toString() {
    return town.isEmpty
        ? '$city, $district, $province, $country'
        : '$town, $city, $district, $province, $country';
  }
}
