import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';

class ProductCardContent extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductCardContent({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Padding(
      padding: EdgeInsets.all(r.spacing(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product['name'] as String,
            style: GoogleFonts.cairo(
              fontSize: r.fontSize(14),
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: r.spacing(8)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${product['price']} IQD',
                style: GoogleFonts.cairo(
                  fontSize: r.fontSize(13),
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              _buildStockBadge(r),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStockBadge(Responsive r) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'Stock: ${product['stock']}',
        style: GoogleFonts.cairo(
          fontSize: r.fontSize(11),
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
