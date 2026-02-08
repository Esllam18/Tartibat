import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../data/models/product_model.dart';
import '../../view/product_details_screen.dart';

class ProductCardList extends StatefulWidget {
  final Product product;

  const ProductCardList({super.key, required this.product});

  @override
  State<ProductCardList> createState() => _ProductCardListState();
}

class _ProductCardListState extends State<ProductCardList> {
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
        height: 130,
        margin: EdgeInsets.only(bottom: r.spacing(12)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(18),
              ),
              child: CachedNetworkImage(
                imageUrl: widget.product.imageUrl,
                width: 130,
                height: 130,
                fit: BoxFit.cover,
                memCacheHeight: 300,
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
                    size: 40,
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(r.spacing(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.product.getName(isArabic),
                            style: GoogleFonts.cairo(
                              fontSize: r.fontSize(15),
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            _isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color:
                                _isFavorite ? Colors.red : Colors.grey.shade600,
                            size: 20,
                          ),
                          onPressed: () =>
                              setState(() => _isFavorite = !_isFavorite),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                    Text(
                      widget.product.merchant,
                      style: GoogleFonts.cairo(
                        fontSize: r.fontSize(12),
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: r.spacing(12),
                        vertical: r.spacing(8),
                      ),
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '\$${widget.product.price.toStringAsFixed(0)}',
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
            ),
          ],
        ),
      ),
    );
  }
}
