import 'package:flutter/material.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/utils/responsive.dart';

class OrderProductsSection extends StatelessWidget {
  final List<dynamic> products;

  const OrderProductsSection({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Container(
      padding: EdgeInsets.all(r.spacing(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'order_products'.tr(context),
            style: TextStyle(
                fontSize: r.fontSize(16), fontWeight: FontWeight.bold),
          ),
          SizedBox(height: r.spacing(12)),
          ...products.map((product) => _buildProductItem(product, r)),
        ],
      ),
    );
  }

  Widget _buildProductItem(dynamic product, Responsive r) {
    return Container(
      margin: EdgeInsets.only(bottom: r.spacing(8)),
      child: Row(
        children: [
          Expanded(
              child: Text(product['name'] ?? '',
                  style: TextStyle(fontSize: r.fontSize(14)))),
          Text(
            'x${product['quantity']}',
            style: TextStyle(
                fontSize: r.fontSize(14), fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
