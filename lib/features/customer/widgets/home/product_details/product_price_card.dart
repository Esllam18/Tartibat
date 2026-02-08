import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/utils/responsive.dart';
import '../../../../../core/localization/app_localizations.dart';

class ProductPriceCard extends StatelessWidget {
  final dynamic price;

  const ProductPriceCard({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Container(
      padding: EdgeInsets.all(r.spacing(20)),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1B7F79), Color(0xFF4DB5AE)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1B7F79).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'price'.tr(context),
                  style: GoogleFonts.cairo(
                    fontSize: r.fontSize(14),
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                SizedBox(height: r.spacing(6)),
                Text(
                  '\$$price',
                  style: GoogleFonts.cairo(
                    fontSize: r.fontSize(32),
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: -1,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(r.spacing(14)),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              Icons.local_offer_rounded,
              color: Colors.white,
              size: r.responsive(mobile: 32, tablet: 36, desktop: 40),
            ),
          ),
        ],
      ),
    );
  }
}
