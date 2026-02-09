class CartItem {
  final String id;
  final String productId;
  final String name;
  final String nameAr;
  final double price;
  final String imageUrl;
  final String merchant;
  int quantity;
  final DateTime addedAt;

  CartItem({
    required this.id,
    required this.productId,
    required this.name,
    required this.nameAr,
    required this.price,
    required this.imageUrl,
    required this.merchant,
    required this.quantity,
    required this.addedAt,
  });

  double get total => price * quantity;

  String getName(bool isArabic) => isArabic ? nameAr : name;

  CartItem copyWith({int? quantity}) {
    return CartItem(
      id: id,
      productId: productId,
      name: name,
      nameAr: nameAr,
      price: price,
      imageUrl: imageUrl,
      merchant: merchant,
      quantity: quantity ?? this.quantity,
      addedAt: addedAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'productId': productId,
        'name': name,
        'nameAr': nameAr,
        'price': price,
        'imageUrl': imageUrl,
        'merchant': merchant,
        'quantity': quantity,
        'addedAt': addedAt.toIso8601String(),
      };

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        id: json['id'] ?? '',
        productId: json['productId'] ?? '',
        name: json['name'] ?? '',
        nameAr: json['nameAr'] ?? '',
        price: (json['price'] ?? 0).toDouble(),
        imageUrl: json['imageUrl'] ?? '',
        merchant: json['merchant'] ?? '',
        quantity: json['quantity'] ?? 1,
        addedAt:
            DateTime.parse(json['addedAt'] ?? DateTime.now().toIso8601String()),
      );
}
