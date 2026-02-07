import 'package:flutter/material.dart';
import 'trader_product_card.dart';

class TraderProductsGrid extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  const TraderProductsGrid({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.75,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return TraderProductCard(product: products[index]);
      },
    );
  }
}
