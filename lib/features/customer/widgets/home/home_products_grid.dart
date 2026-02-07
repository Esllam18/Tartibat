import 'package:flutter/material.dart';
import 'package:tartibat/features/customer/widgets/home/home_product_card.dart';

class HomeProductsGrid extends StatelessWidget {
  final String category;

  const HomeProductsGrid({super.key, required this.category});

  static final List<Map<String, dynamic>> _allProducts = [
    {
      'name': 'كنبة مودرن فاخرة',
      'location': 'صنع في إيطاليا',
      'price': 4500,
      'status': 'approved', // ← Add this
      'image':
          'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=500',
    },
    {
      'name': 'طاولة طعام خشبية',
      'location': 'خشب زان طبيعي',
      'price': 3200,
      'status': 'approved', // ← Add this
      'image':
          'https://images.unsplash.com/photo-1617806118233-18e1de247200?w=500',
    },
    {
      'name': 'كرسي مكتب جلد',
      'location': 'جلد طبيعي',
      'price': 1200,
      'status': 'pending', // ← This won't show to customers
      'image':
          'https://images.unsplash.com/photo-1580480055273-228ff5388ef8?w=500',
    },
    // ... rest of products
  ];

// Add this getter to filter approved only
  List<Map<String, dynamic>> get _products {
    return _allProducts
        .where((product) => product['status'] == 'approved')
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: 0.72,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => ProductCard(product: _products[index]),
          childCount: _products.length,
        ),
      ),
    );
  }
}
