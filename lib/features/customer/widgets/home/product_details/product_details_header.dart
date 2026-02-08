import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/responsive.dart';

class ProductDetailsHeader extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetailsHeader({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product['name'] as String,
          style: GoogleFonts.cairo(
            fontSize: r.fontSize(26),
            fontWeight: FontWeight.w900,
            color: AppColors.textPrimary,
            height: 1.3,
          ),
        ),
        SizedBox(height: r.spacing(12)),
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: r.spacing(10),
                vertical: r.spacing(6),
              ),
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.success.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.verified, size: 18, color: AppColors.success),
                  SizedBox(width: r.spacing(6)),
                  Text(
                    product['location'] as String,
                    style: GoogleFonts.cairo(
                      fontSize: r.fontSize(13),
                      fontWeight: FontWeight.w600,
                      color: AppColors.success,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
