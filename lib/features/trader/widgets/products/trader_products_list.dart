// lib/features/trader/widgets/products/trader_products_list.dart
import 'package:flutter/material.dart';

import 'trader_product_card.dart';

class TraderProductsList extends StatelessWidget {
  final String category;
  const TraderProductsList({super.key, required this.category});

  static final List<Map<String, dynamic>> _products = [
    {
      'id': 'p1',
      'name': 'كنبة مودرن فاخرة',
      'location': 'صنع في إيطاليا',
      'price': 4500,
      'image':
          'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=800',
      'stock': 12,
      'category': 'sofas',
    },
    {
      'id': 'p2',
      'name': 'طاولة طعام خشبية',
      'location': 'خشب زان طبيعي',
      'price': 3200,
      'image':
          'https://images.unsplash.com/photo-1617806118233-18e1de247200?w=800',
      'stock': 5,
      'category': 'tables',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final items = category == 'all'
        ? _products
        : _products.where((p) => p['category'] == category).toList();

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
          child: TraderProductCard(
            product: items[index],
          ),
        ),
        childCount: items.length,
      ),
    );
  }
}
