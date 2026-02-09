class Product {
  final String id;
  final String name;
  final String nameAr;
  final double price;
  final String imageUrl;
  final String merchant;
  final String category;
  final bool isFeatured;

  Product({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.price,
    required this.imageUrl,
    required this.merchant,
    required this.category,
    this.isFeatured = false,
  });

  String getName(bool isArabic) => isArabic ? nameAr : name;
}
