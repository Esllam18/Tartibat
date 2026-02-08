import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/responsive.dart';
import '../../../../../core/localization/app_localizations.dart';

class ProductAddToCartBar extends StatelessWidget {
  final int quantity;
  final dynamic price;

  const ProductAddToCartBar({
    super.key,
    required this.quantity,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final total = (price * quantity).toStringAsFixed(0);

    return Container(
      padding: EdgeInsets.all(r.spacing(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'total'.tr(context),
                  style: GoogleFonts.cairo(
                    fontSize: r.fontSize(13),
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  '\$$total',
                  style: GoogleFonts.cairo(
                    fontSize: r.fontSize(24),
                    fontWeight: FontWeight.w900,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            SizedBox(width: r.spacing(16)),
            Expanded(
              child: SizedBox(
                height: r.responsive(mobile: 56, tablet: 60, desktop: 64),
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            const Icon(Icons.check_circle, color: Colors.white),
                            SizedBox(width: r.spacing(12)),
                            Expanded(child: Text('added_to_cart'.tr(context))),
                          ],
                        ),
                        backgroundColor: AppColors.success,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: r.responsive(mobile: 22, tablet: 24, desktop: 26),
                      ),
                      SizedBox(width: r.spacing(10)),
                      Text(
                        'add_to_cart'.tr(context),
                        style: GoogleFonts.cairo(
                          fontSize: r.fontSize(16),
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
