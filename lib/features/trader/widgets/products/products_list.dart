import 'package:flutter/material.dart';
import 'package:tartibat/features/trader/widgets/orders/order_card.dart';
import '../../../../core/utils/responsive.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return GridView.builder(
      padding: EdgeInsets.all(r.paddingHorizontal),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: r.gridColumns,
        crossAxisSpacing: r.spacing(12),
        mainAxisSpacing: r.spacing(12),
        childAspectRatio: 0.75,
      ),
      itemCount: 12,
      itemBuilder: (context, index) => TraderOrderCard(
        index: index,
        status: 'new',
      ),
    );
  }
}
