import 'package:flutter/material.dart';
import '../../../../core/utils/responsive.dart';
import '../../data/models/product_model.dart';
import 'product_card_grid.dart';

class HomeProductsSection extends StatelessWidget {
  final List<Product> products;

  const HomeProductsSection({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    if (products.isEmpty) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(r.spacing(40)),
          child: Center(
            child: Text(
              'No products found',
              style: TextStyle(
                fontSize: r.fontSize(16),
                color: Colors.grey,
              ),
            ),
          ),
        ),
      );
    }

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: r.spacing(16)),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: r.responsive(mobile: 2, tablet: 3, desktop: 4),
          crossAxisSpacing: r.spacing(12),
          mainAxisSpacing: r.spacing(12),
          childAspectRatio: 0.68,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => ProductCardGrid(product: products[index]),
          childCount: products.length > 6 ? 6 : products.length,
        ),
      ),
    );
  }
}
