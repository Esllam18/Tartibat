class FavoriteModel {
  final String id;
  final String name;
  final String nameAr;
  final double price;
  final String imageUrl;
  final String merchant;
  final String category;
  final DateTime addedAt;

  FavoriteModel({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.price,
    required this.imageUrl,
    required this.merchant,
    required this.category,
    required this.addedAt,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      nameAr: json['nameAr'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      imageUrl: json['imageUrl'] ?? '',
      merchant: json['merchant'] ?? '',
      category: json['category'] ?? '',
      addedAt:
          DateTime.parse(json['addedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nameAr': nameAr,
      'price': price,
      'imageUrl': imageUrl,
      'merchant': merchant,
      'category': category,
      'addedAt': addedAt.toIso8601String(),
    };
  }

  String getName(bool isArabic) => isArabic ? nameAr : name;
}
