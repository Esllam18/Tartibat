import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../data/models/product_model.dart';
import '../../view/product_details_screen.dart';

class ProductCardGrid extends StatefulWidget {
  final Product product;

  const ProductCardGrid({super.key, required this.product});

  @override
  State<ProductCardGrid> createState() => _ProductCardGridState();
}

class _ProductCardGridState extends State<ProductCardGrid> {
  bool _isFavorite = false;

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
              'name': widget.product.getName(isArabic),
              'price': widget.product.price,
              'image': widget.product.imageUrl,
              'location': widget.product.merchant,
            },
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 10,
              child: _buildImage(r),
            ),
            Padding(
              padding: EdgeInsets.all(r.spacing(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.getName(isArabic),
                    style: GoogleFonts.cairo(
                      fontSize: r.fontSize(13),
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: r.spacing(4)),
                  Text(
                    widget.product.merchant,
                    style: GoogleFonts.cairo(
                      fontSize: r.fontSize(11),
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: r.spacing(8)),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: r.spacing(6)),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '\$${widget.product.price.toStringAsFixed(0)}',
                      style: GoogleFonts.cairo(
                        fontSize: r.fontSize(12),
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
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

  Widget _buildImage(Responsive r) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: CachedNetworkImage(
            imageUrl: widget.product.imageUrl,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            memCacheHeight: 400,
            placeholder: (_, __) => Container(
              color: Colors.grey.shade100,
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.primary,
                ),
              ),
            ),
            errorWidget: (_, __, ___) => Container(
              color: Colors.grey.shade100,
              child: Icon(
                Icons.image_not_supported_outlined,
                size: 30,
                color: Colors.grey.shade400,
              ),
            ),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: () => setState(() => _isFavorite = !_isFavorite),
            child: Container(
              padding: EdgeInsets.all(r.spacing(6)),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                size: 16,
                color: _isFavorite ? Colors.red : Colors.grey.shade600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
