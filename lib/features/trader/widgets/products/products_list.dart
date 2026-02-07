import 'package:flutter/material.dart';
import '../../../../core/utils/responsive.dart';
import 'product_card_list.dart';

class ProductsList extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  const ProductsList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return ListView.builder(
      padding: EdgeInsets.all(r.spacing(16)),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCardList(product: products[index]);
      },
    );
  }
}
