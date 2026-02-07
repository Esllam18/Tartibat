import 'package:flutter/material.dart';
import '../../../../core/utils/responsive.dart';
import 'product_card_grid.dart';

class ProductsGrid extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  const ProductsGrid({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return GridView.builder(
      padding: EdgeInsets.all(r.spacing(16)),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: r.responsive(mobile: 2, tablet: 3, desktop: 4),
        crossAxisSpacing: r.spacing(12),
        mainAxisSpacing: r.spacing(12),
        childAspectRatio: 0.75,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCardGrid(product: products[index]);
      },
    );
  }
}
