import 'package:flutter/material.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/utils/responsive.dart';

class ProductCardList extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductCardList({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Container(
      margin: EdgeInsets.only(bottom: r.spacing(12)),
      padding: EdgeInsets.all(r.spacing(12)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              product['image'] ?? '',
              width: r.responsive(mobile: 80, tablet: 100, desktop: 120),
              height: r.responsive(mobile: 80, tablet: 100, desktop: 120),
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: r.responsive(mobile: 80, tablet: 100, desktop: 120),
                height: r.responsive(mobile: 80, tablet: 100, desktop: 120),
                color: Colors.grey[100],
                child: const Icon(Icons.image, size: 40, color: Colors.black26),
              ),
            ),
          ),
          SizedBox(width: r.spacing(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['name'] ?? '',
                  style: TextStyle(
                      fontSize: r.fontSize(16), fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: r.spacing(8)),
                Text(
                  '${product['price']} ${'iqd'.tr(context)}',
                  style: TextStyle(
                      fontSize: r.fontSize(16), fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
