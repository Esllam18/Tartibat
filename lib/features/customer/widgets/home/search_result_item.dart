import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../data/models/product_model.dart';
import '../../view/product_details_screen.dart';

class SearchResultItem extends StatelessWidget {
  final Product product;

  const SearchResultItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProductDetailsScreen(
            product: {
              'name': product.getName(isArabic),
              'price': product.price,
              'image': product.imageUrl,
              'location': product.merchant,
            },
          ),
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: r.spacing(12)),
        padding: EdgeInsets.all(r.spacing(12)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: product.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                memCacheHeight: 200,
                placeholder: (_, __) => Container(
                  color: Colors.grey.shade100,
                  child: const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              ),
            ),
            SizedBox(width: r.spacing(12)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.getName(isArabic),
                    style: GoogleFonts.cairo(
                      fontSize: r.fontSize(15),
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: r.spacing(4)),
                  Text(
                    product.merchant,
                    style: GoogleFonts.cairo(
                      fontSize: r.fontSize(13),
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: r.spacing(6)),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: r.spacing(12),
                      vertical: r.spacing(6),
                    ),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '\$${product.price.toStringAsFixed(0)}',
                      style: GoogleFonts.cairo(
                        fontSize: r.fontSize(14),
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
