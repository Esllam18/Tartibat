import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../customer/data/models/product_model.dart';
import '../../bloc/merchant_products_cubit.dart';
import '../../view/edit_product_screen.dart';

class MerchantProductCard extends StatelessWidget {
  final Product product;

  const MerchantProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Container(
      margin: EdgeInsets.only(bottom: r.spacing(12)),
      padding: EdgeInsets.all(r.spacing(12)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
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
              placeholder: (_, __) => Container(color: Colors.grey.shade100),
              errorWidget: (_, __, ___) => Container(
                color: Colors.grey.shade100,
                child: Icon(Icons.image, color: Colors.grey.shade400),
              ),
            ),
          ),
          SizedBox(width: r.spacing(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        product.getName(isArabic),
                        style: GoogleFonts.cairo(
                          fontSize: r.fontSize(15),
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: r.spacing(8),
                        vertical: r.spacing(4),
                      ),
                      decoration: BoxDecoration(
                        color: product.isAvailable
                            ? AppColors.success.withOpacity(0.1)
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        product.isAvailable
                            ? 'active'.tr(context)
                            : 'inactive'.tr(context),
                        style: GoogleFonts.cairo(
                          fontSize: r.fontSize(11),
                          fontWeight: FontWeight.w700,
                          color: product.isAvailable
                              ? AppColors.success
                              : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: r.spacing(8)),
                Row(
                  children: [
                    Text(
                      '\$${product.price.toStringAsFixed(0)}',
                      style: GoogleFonts.cairo(
                        fontSize: r.fontSize(18),
                        fontWeight: FontWeight.w900,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(width: r.spacing(12)),
                    Icon(Icons.category,
                        size: 14, color: AppColors.textSecondary),
                    SizedBox(width: r.spacing(4)),
                    Text(
                      product.category,
                      style: GoogleFonts.cairo(
                        fontSize: r.fontSize(12),
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: AppColors.primary),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<MerchantProductsCubit>(),
                        child: EditProductScreen(product: product),
                      ),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: AppColors.error),
                onPressed: () => _showDeleteDialog(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    final r = context.responsive;

    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          padding: EdgeInsets.all(r.spacing(24)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.delete_outline, color: AppColors.error, size: 48),
              SizedBox(height: r.spacing(16)),
              Text(
                'delete_product'.tr(context),
                style: GoogleFonts.cairo(
                  fontSize: r.fontSize(20),
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: r.spacing(12)),
              Text(
                'delete_product_confirm'.tr(context),
                style: GoogleFonts.cairo(
                  fontSize: r.fontSize(14),
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: r.spacing(24)),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: r.spacing(12)),
                        side: BorderSide(color: Colors.grey.shade300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'cancel'.tr(context),
                        style: GoogleFonts.cairo(
                          fontSize: r.fontSize(14),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: r.spacing(12)),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        context
                            .read<MerchantProductsCubit>()
                            .deleteProduct(product.id);
                        Navigator.pop(dialogContext);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.error,
                        padding: EdgeInsets.symmetric(vertical: r.spacing(12)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'delete'.tr(context),
                        style: GoogleFonts.cairo(
                          fontSize: r.fontSize(14),
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
