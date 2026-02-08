class Product {
  final String id;
  final String name;
  final String nameAr;
  final String description;
  final String descriptionAr;
  final double price;
  final String category;
  final String merchant;
  final String imageUrl;
  final double rating;
  final int reviewsCount;
  final bool isAvailable;
  final bool isFeatured;

  const Product({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.description,
    required this.descriptionAr,
    required this.price,
    required this.category,
    required this.merchant,
    required this.imageUrl,
    this.rating = 0.0,
    this.reviewsCount = 0,
    this.isAvailable = true,
    this.isFeatured = false,
  });

  String getName(bool isArabic) => isArabic ? nameAr : name;
  String getDescription(bool isArabic) =>
      isArabic ? descriptionAr : description;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'nameAr': nameAr,
        'description': description,
        'descriptionAr': descriptionAr,
        'price': price,
        'category': category,
        'merchant': merchant,
        'imageUrl': imageUrl,
        'rating': rating,
        'reviewsCount': reviewsCount,
        'isAvailable': isAvailable,
        'isFeatured': isFeatured,
      };

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        name: json['name'],
        nameAr: json['nameAr'],
        description: json['description'],
        descriptionAr: json['descriptionAr'],
        price: json['price'].toDouble(),
        category: json['category'],
        merchant: json['merchant'],
        imageUrl: json['imageUrl'],
        rating: json['rating']?.toDouble() ?? 0.0,
        reviewsCount: json['reviewsCount'] ?? 0,
        isAvailable: json['isAvailable'] ?? true,
        isFeatured: json['isFeatured'] ?? false,
      );
}
