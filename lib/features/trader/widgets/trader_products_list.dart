import 'package:flutter/material.dart';
import 'product_list_item.dart';

class TraderProductsList extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  const TraderProductsList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductListItem(product: products[index]);
      },
    );
  }
}
