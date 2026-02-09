class Product {
  final String id;
  final String name;
  final String nameAr;
  final double price;
  final String category;
  final String imageUrl;
  final String merchant;
  final double rating;
  final bool isAvailable;
  final bool isFeatured;

  Product({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.price,
    required this.category,
    required this.imageUrl,
    required this.merchant,
    this.rating = 4.5,
    this.isAvailable = true,
    this.isFeatured = false,
  });

  String getName(bool isArabic) => isArabic ? nameAr : name;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'nameAr': nameAr,
        'price': price,
        'category': category,
        'imageUrl': imageUrl,
        'merchant': merchant,
        'rating': rating,
        'isAvailable': isAvailable,
        'isFeatured': isFeatured,
      };

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        nameAr: json['nameAr'] ?? '',
        price: (json['price'] ?? 0).toDouble(),
        category: json['category'] ?? '',
        imageUrl: json['imageUrl'] ?? '',
        merchant: json['merchant'] ?? '',
        rating: (json['rating'] ?? 4.5).toDouble(),
        isAvailable: json['isAvailable'] ?? true,
        isFeatured: json['isFeatured'] ?? false,
      );

  Product copyWith({
    String? id,
    String? name,
    String? nameAr,
    double? price,
    String? category,
    String? imageUrl,
    String? merchant,
    double? rating,
    bool? isAvailable,
    bool? isFeatured,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      nameAr: nameAr ?? this.nameAr,
      price: price ?? this.price,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      merchant: merchant ?? this.merchant,
      rating: rating ?? this.rating,
      isAvailable: isAvailable ?? this.isAvailable,
      isFeatured: isFeatured ?? this.isFeatured,
    );
  }
}
