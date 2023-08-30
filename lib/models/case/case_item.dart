import 'package:hive_flutter/hive_flutter.dart';
part 'case_item.g.dart';

@HiveType(typeId: 52)
class CaseItem {
  CaseItem({
    required this.id,
    required this.isTest,
    required this.price,
    required this.quantity,
    required this.discountInPercent,
  });

  @HiveField(0)
  final String id;
  @HiveField(1)
  final bool isTest;
  @HiveField(2)
  final double price;
  @HiveField(3)
  int quantity;
  @HiveField(4)
  final double discountInPercent;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'is_test': isTest,
      'price': price,
      'quantity': quantity,
      'discount_in_percent': discountInPercent,
      'discount_in_rupees': discountInRupees,
      'total': total,
    };
  }

  // ignore: sort_constructors_first
  factory CaseItem.fromMap(Map<String, dynamic> map) {
    return CaseItem(
      id: map['id'] ?? '',
      isTest: map['is_test'] ?? false,
      price: map['price'] ?? 0.0,
      quantity: map['quantity'] ?? 0,
      discountInPercent: map['discount_in_percent'] ?? 0.0,
    );
  }

  double get total => (price * quantity) - discountInRupees;
  double get discountInRupees => (price * quantity) * (discountInPercent / 100);
}
