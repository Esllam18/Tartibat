import 'cart_item_model.dart';
import 'delivery_address_model.dart';

class Order {
  final String id;
  final List<CartItem> items;
  final DeliveryAddress address;
  final String paymentMethod;
  final double total;
  final DateTime createdAt;
  final String status;

  Order({
    required this.id,
    required this.items,
    required this.address,
    required this.paymentMethod,
    required this.total,
    required this.createdAt,
    this.status = 'pending',
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'items': items.map((item) => item.toJson()).toList(),
        'address': address.toJson(),
        'paymentMethod': paymentMethod,
        'total': total,
        'createdAt': createdAt.toIso8601String(),
        'status': status,
      };

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json['id'] ?? '',
        items: (json['items'] as List<dynamic>?)
                ?.map((item) => CartItem.fromJson(item))
                .toList() ??
            [],
        address: DeliveryAddress.fromJson(json['address'] ?? {}),
        paymentMethod: json['paymentMethod'] ?? '',
        total: (json['total'] ?? 0).toDouble(),
        createdAt: DateTime.parse(
            json['createdAt'] ?? DateTime.now().toIso8601String()),
        status: json['status'] ?? 'pending',
      );
}
