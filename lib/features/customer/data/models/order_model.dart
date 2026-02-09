import 'address_model.dart';

// OrderItem - mirrors CartItem structure
class OrderItem {
  final String productId;
  final String name;
  final String nameAr;
  final String imageUrl;
  final int quantity;
  final double price;

  OrderItem({
    required this.productId,
    required this.name,
    required this.nameAr,
    required this.imageUrl,
    required this.quantity,
    required this.price,
  });

  double get total => price * quantity;

  String getName(bool isArabic) => isArabic ? nameAr : name;

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'name': name,
        'nameAr': nameAr,
        'imageUrl': imageUrl,
        'quantity': quantity,
        'price': price,
      };

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        productId: json['productId'] ?? '',
        name: json['name'] ?? '',
        nameAr: json['nameAr'] ?? '',
        imageUrl: json['imageUrl'] ?? '',
        quantity: json['quantity'] ?? 0,
        price: (json['price'] ?? 0).toDouble(),
      );
}

class Order {
  final String id;
  final List<OrderItem> items;
  final Address address;
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
        items: (json['items'] as List?)
                ?.map(
                    (item) => OrderItem.fromJson(item as Map<String, dynamic>))
                .toList() ??
            [],
        address:
            Address.fromJson(json['address'] as Map<String, dynamic>? ?? {}),
        paymentMethod: json['paymentMethod'] ?? '',
        total: (json['total'] ?? 0).toDouble(),
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : DateTime.now(),
        status: json['status'] ?? 'pending',
      );

  String getStatusLabel(bool isArabic) {
    const statusMap = {
      'pending': {'en': 'Pending', 'ar': 'قيد الانتظار'},
      'confirmed': {'en': 'Confirmed', 'ar': 'مؤكد'},
      'processing': {'en': 'Processing', 'ar': 'قيد التحضير'},
      'shipped': {'en': 'Shipped', 'ar': 'تم الشحن'},
      'outForDelivery': {'en': 'Out for Delivery', 'ar': 'في الطريق للتوصيل'},
      'delivered': {'en': 'Delivered', 'ar': 'تم التوصيل'},
      'cancelled': {'en': 'Cancelled', 'ar': 'ملغي'},
    };

    final labels = statusMap[status];
    return labels?[isArabic ? 'ar' : 'en'] ?? status;
  }
}
