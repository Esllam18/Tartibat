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
      print('📦 5 Products added');
      print('📋 4 Orders added (different statuses)');
    } else {
      print('✅ Test data already exists');
    }
  }

  static Future<void> _seedProducts(SharedPreferences prefs) async {
    final products = [
      {
        'id': 'PROD001',
        'name': 'Modern Leather Sofa',
        'nameAr': 'كنب جلد مودرن',
        'price': 299.99,
        'category': 'Living Room',
        'imageUrl':
            'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=500',
        'mediaUrls': [
          'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=500',
          'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?w=500',
        ],
        'merchant': 'Premium Furniture',
        'rating': 4.8,
        'isAvailable': true,
        'isFeatured': true,
      },
      {
        'id': 'PROD002',
        'name': 'Classic Dining Table',
        'nameAr': 'طاولة طعام كلاسيكية',
        'price': 450.00,
        'category': 'Dining Room',
        'imageUrl':
            'https://images.unsplash.com/photo-1617806118233-18e1de247200?w=500',
        'mediaUrls': [
          'https://images.unsplash.com/photo-1617806118233-18e1de247200?w=500',
        ],
        'merchant': 'Wood Crafters',
        'rating': 4.9,
        'isAvailable': true,
        'isFeatured': true,
      },
      {
        'id': 'PROD003',
        'name': 'King Size Bed Frame',
        'nameAr': 'سرير كينج سايز',
        'price': 599.99,
        'category': 'Bedroom',
        'imageUrl':
            'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=500',
        'mediaUrls': [
          'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=500',
        ],
        'merchant': 'Sleep Haven',
        'rating': 4.7,
        'isAvailable': true,
        'isFeatured': false,
      },
      {
        'id': 'PROD004',
        'name': 'Office Desk',
        'nameAr': 'مكتب مكتبي',
        'price': 199.99,
        'category': 'Office',
        'imageUrl':
            'https://images.unsplash.com/photo-1518455027359-f3f8164ba6bd?w=500',
        'mediaUrls': [
          'https://images.unsplash.com/photo-1518455027359-f3f8164ba6bd?w=500',
        ],
        'merchant': 'Office Pro',
        'rating': 4.5,
        'isAvailable': true,
        'isFeatured': false,
      },
      {
        'id': 'PROD005',
        'name': 'Bookshelf Cabinet',
        'nameAr': 'خزانة كتب',
        'price': 149.99,
        'category': 'Storage',
        'imageUrl':
            'https://images.unsplash.com/photo-1594620302200-9a762244a156?w=500',
        'mediaUrls': [
          'https://images.unsplash.com/photo-1594620302200-9a762244a156?w=500',
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
      // Order 1 - Pending
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

      // Order 2 - Confirmed
      {
        'id':
            'ORD${now.subtract(const Duration(days: 1)).millisecondsSinceEpoch}',
        'items': [
          {
            'productId': 'PROD002',
            'name': 'Classic Dining Table',
            'nameAr': 'طاولة طعام كلاسيكية',
            'imageUrl':
                'https://images.unsplash.com/photo-1617806118233-18e1de247200?w=500',
            'quantity': 1,
            'price': 450.00,
          },
          {
            'productId': 'PROD005',
            'name': 'Bookshelf Cabinet',
            'nameAr': 'خزانة كتب',
            'imageUrl':
                'https://images.unsplash.com/photo-1594620302200-9a762244a156?w=500',
            'quantity': 2,
            'price': 149.99,
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
        'paymentMethod': 'cash',
        'total': 749.98,
        'createdAt': now.subtract(const Duration(days: 1)).toIso8601String(),
        'status': 'confirmed',
      },

      // Order 3 - Shipped
      {
        'id':
            'ORD${now.subtract(const Duration(days: 3)).millisecondsSinceEpoch}',
        'items': [
          {
            'productId': 'PROD003',
            'name': 'King Size Bed Frame',
            'nameAr': 'سرير كينج سايز',
            'imageUrl':
                'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=500',
            'quantity': 1,
            'price': 599.99,
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
        'total': 599.99,
        'createdAt': now.subtract(const Duration(days: 3)).toIso8601String(),
        'status': 'shipped',
      },

      // Order 4 - Delivered
      {
        'id':
            'ORD${now.subtract(const Duration(days: 7)).millisecondsSinceEpoch}',
        'items': [
          {
            'productId': 'PROD004',
            'name': 'Office Desk',
            'nameAr': 'مكتب مكتبي',
            'imageUrl':
                'https://images.unsplash.com/photo-1518455027359-f3f8164ba6bd?w=500',
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
          'floor': '3',
          'apartment': '12',
          'city': 'Cairo',
          'area': 'Downtown',
          'isDefault': true,
        },
        'paymentMethod': 'cash',
        'total': 199.99,
        'createdAt': now.subtract(const Duration(days: 7)).toIso8601String(),
        'status': 'delivered',
      },
    ];

    await prefs.setString('shared_orders', jsonEncode(orders));
    print('✅ Orders seeded: ${orders.length}');
  }

  // Clear all test data
  static Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('products');
    await prefs.remove('shared_orders');
    await prefs.remove('test_data_seeded');
    print('🗑️ All test data cleared!');
  }

  // Reset and re-seed
  static Future<void> resetData() async {
    await clearAllData();
    await initialize();
  }
}
