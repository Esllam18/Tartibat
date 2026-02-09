import '../models/product_model.dart';

final List<Product> mockProducts = [
  Product(
    id: 'prod_001',
    name: 'Modern Luxury Sofa',
    nameAr: 'كنبة فاخرة عصرية',
    price: 4500,
    imageUrl: 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc',
    merchant: 'Elite Furniture',
    category: 'living_room',
    isFeatured: true,
  ),
  Product(
    id: 'prod_002',
    name: 'Elegant Dining Table',
    nameAr: 'طاولة طعام أنيقة',
    price: 3200,
    imageUrl: 'https://images.unsplash.com/photo-1617806118233-18e1de247200',
    merchant: 'Wood Masters',
    category: 'dining_room',
    isFeatured: true,
  ),
  Product(
    id: 'prod_003',
    name: 'King Size Bed',
    nameAr: 'سرير كينج سايز',
    price: 5500,
    imageUrl: 'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85',
    merchant: 'Sleep Haven',
    category: 'bedroom',
    isFeatured: true,
  ),
  // Add more products with unique IDs...
];
