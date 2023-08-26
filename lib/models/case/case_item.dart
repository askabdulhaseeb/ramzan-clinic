class CaseItem {
  CaseItem({
    required this.id,
    required this.isTest,
    required this.price,
    required this.quantity,
    required this.discountInPercent,
    required this.discountInRupees,
    required this.total,
  });

  final String id;
  final bool isTest;
  final double price;
  final int quantity;
  final double discountInPercent;
  final double discountInRupees;
  final double total;

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
      discountInRupees: map['discount_in_rupees'] ?? 0.0,
      total: map['total'] ?? 0.0,
    );
  }
}
