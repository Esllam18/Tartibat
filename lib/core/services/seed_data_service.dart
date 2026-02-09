import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SeedDataService {
  static Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final seeded = prefs.getBool('test_data_seeded') ?? false;

    if (!seeded) {
      await _seedProducts(prefs);
      await _seedOrders(prefs);
      await prefs.setBool('test_data_seeded', true);
      print('✅ Test data initialized successfully!');
      print('📦 10 Products added');
      print('📋 6 Orders added (various statuses)');
    } else {
      print('✅ Test data already exists');
    }
  }

  static Future<void> _seedProducts(SharedPreferences prefs) async {
    final products = [
      // Living Room
      {
        'id': 'PROD001',
        'name': 'Modern Leather Sofa',
        'nameAr': 'كنب جلد مودرن',
        'price': 299.99,
        'category': 'Living Room',
        'imageUrl':
            'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=500',
        'mediaUrls': [
          'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=500'
        ],
        'merchant': 'Premium Furniture',
        'rating': 4.8,
        'isAvailable': true,
        'isFeatured': true,
      },
      {
        'id': 'PROD002',
        'name': 'L-Shape Corner Sofa',
        'nameAr': 'كنب زاوية شكل L',
        'price': 449.99,
        'category': 'Living Room',
        'imageUrl':
            'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?w=500',
        'mediaUrls': [
          'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?w=500'
        ],
        'merchant': 'Comfort Zone',
        'rating': 4.9,
        'isAvailable': true,
        'isFeatured': true,
      },

      // Dining Room
      {
        'id': 'PROD003',
        'name': 'Classic Dining Table',
        'nameAr': 'طاولة طعام كلاسيكية',
        'price': 450.00,
        'category': 'Dining Room',
        'imageUrl':
            'https://images.unsplash.com/photo-1617806118233-18e1de247200?w=500',
        'mediaUrls': [
          'https://images.unsplash.com/photo-1617806118233-18e1de247200?w=500'
        ],
        'merchant': 'Wood Crafters',
        'rating': 4.7,
        'isAvailable': true,
        'isFeatured': true,
      },
      {
        'id': 'PROD004',
        'name': 'Wooden Dining Chairs (Set of 4)',
        'nameAr': 'كراسي طعام خشبية (مجموعة 4)',
        'price': 199.99,
        'category': 'Dining Room',
        'imageUrl':
            'https://images.unsplash.com/photo-1503602642458-232111445657?w=500',
        'mediaUrls': [
          'https://images.unsplash.com/photo-1503602642458-232111445657?w=500'
        ],
        'merchant': 'Wood Crafters',
        'rating': 4.6,
        'isAvailable': true,
        'isFeatured': false,
      },

      // Bedroom
      {
        'id': 'PROD005',
        'name': 'King Size Bed Frame',
        'nameAr': 'سرير كينج سايز',
        'price': 599.99,
        'category': 'Bedroom',
        'imageUrl':
            'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=500',
        'mediaUrls': [
          'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=500'
        ],
        'merchant': 'Sleep Haven',
        'rating': 4.9,
        'isAvailable': true,
        'isFeatured': true,
      },
      {
        'id': 'PROD006',
        'name': 'Bedside Table',
        'nameAr': 'طاولة جانبية للسرير',
        'price': 89.99,
        'category': 'Bedroom',
        'imageUrl':
            'https://images.unsplash.com/photo-1519710164239-da123dc03ef4?w=500',
        'mediaUrls': [
          'https://images.unsplash.com/photo-1519710164239-da123dc03ef4?w=500'
        ],
        'merchant': 'Sleep Haven',
        'rating': 4.5,
        'isAvailable': true,
        'isFeatured': false,
      },
      {
        'id': 'PROD007',
        'name': 'Luxury Wardrobe',
        'nameAr': 'دولاب فاخر',
        'price': 799.99,
        'category': 'Bedroom',
        'imageUrl':
            'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=500',
        'mediaUrls': [
          'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=500'
        ],
        'merchant': 'Elite Storage',
        'rating': 4.8,
        'isAvailable': true,
        'isFeatured': false,
      },

      // Office
      {
        'id': 'PROD008',
        'name': 'Executive Office Desk',
        'nameAr': 'مكتب تنفيذي',
        'price': 349.99,
        'category': 'Office',
        'imageUrl':
            'https://images.unsplash.com/photo-1518455027359-f3f8164ba6bd?w=500',
        'mediaUrls': [
          'https://images.unsplash.com/photo-1518455027359-f3f8164ba6bd?w=500'
        ],
        'merchant': 'Office Pro',
        'rating': 4.7,
        'isAvailable': true,
        'isFeatured': false,
      },
      {
        'id': 'PROD009',
        'name': 'Ergonomic Office Chair',
        'nameAr': 'كرسي مكتب مريح',
        'price': 249.99,
        'category': 'Office',
        'imageUrl':
            'https://images.unsplash.com/photo-1580480055273-228ff5388ef8?w=500',
        'mediaUrls': [
          'https://images.unsplash.com/photo-1580480055273-228ff5388ef8?w=500'
        ],
        'merchant': 'Office Pro',
        'rating': 4.9,
        'isAvailable': true,
        'isFeatured': true,
      },

      // Storage
      {
        'id': 'PROD010',
        'name': 'Bookshelf Cabinet',
        'nameAr': 'خزانة كتب',
        'price': 149.99,
        'category': 'Storage',
        'imageUrl':
            'https://images.unsplash.com/photo-1594620302200-9a762244a156?w=500',
        'mediaUrls': [
          'https://images.unsplash.com/photo-1594620302200-9a762244a156?w=500'
        ],
        'merchant': 'Storage Solutions',
        'rating': 4.6,
        'isAvailable': true,
        'isFeatured': false,
      },
    ];

    await prefs.setString('products', jsonEncode(products));
    print('✅ Products seeded: ${products.length}');
  }

  static Future<void> _seedOrders(SharedPreferences prefs) async {
    final now = DateTime.now();

    final orders = [
      // Order 1 - Pending (Today)
      {
        'id': 'ORD${now.millisecondsSinceEpoch}',
        'items': [
          {
            'productId': 'PROD001',
            'name': 'Modern Leather Sofa',
            'nameAr': 'كنب جلد مودرن',
            'imageUrl':
                'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=500',
            'quantity': 1,
            'price': 299.99,
          }
        ],
        'address': {
          'id': 'ADDR001',
          'name': 'Ahmed Mohamed',
          'phone': '+201234567890',
          'street': 'Tahrir Street',
          'building': '15',
          'floor': '3',
          'apartment': '12',
          'city': 'Cairo',
          'area': 'Downtown',
          'isDefault': true,
        },
        'paymentMethod': 'card',
        'total': 299.99,
        'createdAt': now.toIso8601String(),
        'status': 'pending',
      },

      // Order 2 - Confirmed (Yesterday)
      {
        'id':
            'ORD${now.subtract(const Duration(days: 1)).millisecondsSinceEpoch}',
        'items': [
          {
            'productId': 'PROD003',
            'name': 'Classic Dining Table',
            'nameAr': 'طاولة طعام كلاسيكية',
            'imageUrl':
                'https://images.unsplash.com/photo-1617806118233-18e1de247200?w=500',
            'quantity': 1,
            'price': 450.00,
          },
          {
            'productId': 'PROD004',
            'name': 'Wooden Dining Chairs (Set of 4)',
            'nameAr': 'كراسي طعام خشبية (مجموعة 4)',
            'imageUrl':
                'https://images.unsplash.com/photo-1503602642458-232111445657?w=500',
            'quantity': 1,
            'price': 199.99,
          }
        ],
        'address': {
          'id': 'ADDR001',
          'name': 'Ahmed Mohamed',
          'phone': '+201234567890',
          'street': 'Tahrir Street',
          'building': '15',
          'city': 'Cairo',
          'area': 'Downtown',
          'isDefault': true,
        },
        'paymentMethod': 'cash',
        'total': 649.99,
        'createdAt': now.subtract(const Duration(days: 1)).toIso8601String(),
        'status': 'confirmed',
      },

      // Order 3 - Processing (2 days ago)
      {
        'id':
            'ORD${now.subtract(const Duration(days: 2)).millisecondsSinceEpoch}',
        'items': [
          {
            'productId': 'PROD009',
            'name': 'Ergonomic Office Chair',
            'nameAr': 'كرسي مكتب مريح',
            'imageUrl':
                'https://images.unsplash.com/photo-1580480055273-228ff5388ef8?w=500',
            'quantity': 2,
            'price': 249.99,
          }
        ],
        'address': {
          'id': 'ADDR002',
          'name': 'Sara Ali',
          'phone': '+201098765432',
          'street': 'Pyramids Road',
          'building': '20',
          'city': 'Giza',
          'area': 'Haram',
          'isDefault': false,
        },
        'paymentMethod': 'card',
        'total': 499.98,
        'createdAt': now.subtract(const Duration(days: 2)).toIso8601String(),
        'status': 'processing',
      },

      // Order 4 - Shipped (4 days ago)
      {
        'id':
            'ORD${now.subtract(const Duration(days: 4)).millisecondsSinceEpoch}',
        'items': [
          {
            'productId': 'PROD005',
            'name': 'King Size Bed Frame',
            'nameAr': 'سرير كينج سايز',
            'imageUrl':
                'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=500',
            'quantity': 1,
            'price': 599.99,
          },
          {
            'productId': 'PROD006',
            'name': 'Bedside Table',
            'nameAr': 'طاولة جانبية للسرير',
            'imageUrl':
                'https://images.unsplash.com/photo-1519710164239-da123dc03ef4?w=500',
            'quantity': 2,
            'price': 89.99,
          }
        ],
        'address': {
          'id': 'ADDR001',
          'name': 'Ahmed Mohamed',
          'phone': '+201234567890',
          'street': 'Tahrir Street',
          'building': '15',
          'city': 'Cairo',
          'area': 'Downtown',
          'isDefault': true,
        },
        'paymentMethod': 'card',
        'total': 779.97,
        'createdAt': now.subtract(const Duration(days: 4)).toIso8601String(),
        'status': 'shipped',
      },

      // Order 5 - Out for Delivery (6 days ago)
      {
        'id':
            'ORD${now.subtract(const Duration(days: 6)).millisecondsSinceEpoch}',
        'items': [
          {
            'productId': 'PROD002',
            'name': 'L-Shape Corner Sofa',
            'nameAr': 'كنب زاوية شكل L',
            'imageUrl':
                'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?w=500',
            'quantity': 1,
            'price': 449.99,
          }
        ],
        'address': {
          'id': 'ADDR003',
          'name': 'Omar Hassan',
          'phone': '+201555444333',
          'street': 'Nile Corniche',
          'building': '5',
          'city': 'Cairo',
          'area': 'Maadi',
          'isDefault': false,
        },
        'paymentMethod': 'cash',
        'total': 449.99,
        'createdAt': now.subtract(const Duration(days: 6)).toIso8601String(),
        'status': 'outForDelivery',
      },

      // Order 6 - Delivered (10 days ago)
      {
        'id':
            'ORD${now.subtract(const Duration(days: 10)).millisecondsSinceEpoch}',
        'items': [
          {
            'productId': 'PROD008',
            'name': 'Executive Office Desk',
            'nameAr': 'مكتب تنفيذي',
            'imageUrl':
                'https://images.unsplash.com/photo-1518455027359-f3f8164ba6bd?w=500',
            'quantity': 1,
            'price': 349.99,
          },
          {
            'productId': 'PROD010',
            'name': 'Bookshelf Cabinet',
            'nameAr': 'خزانة كتب',
            'imageUrl':
                'https://images.unsplash.com/photo-1594620302200-9a762244a156?w=500',
            'quantity': 1,
            'price': 149.99,
          }
        ],
        'address': {
          'id': 'ADDR001',
          'name': 'Ahmed Mohamed',
          'phone': '+201234567890',
          'street': 'Tahrir Street',
          'building': '15',
          'city': 'Cairo',
          'area': 'Downtown',
          'isDefault': true,
        },
        'paymentMethod': 'card',
        'total': 499.98,
        'createdAt': now.subtract(const Duration(days: 10)).toIso8601String(),
        'status': 'delivered',
      },
    ];

    await prefs.setString('shared_orders', jsonEncode(orders));
    print('✅ Orders seeded: ${orders.length}');
  }

  static Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('products');
    await prefs.remove('shared_orders');
    await prefs.remove('test_data_seeded');
    print('🗑️ All test data cleared!');
  }

  static Future<void> resetData() async {
    await clearAllData();
    await initialize();
  }
}
