import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tartibat/features/customer/data/bloc/cart_cubit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../data/models/cart_item_model.dart';

class CartItemCard extends StatelessWidget {
  final CartItem item;

  const CartItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Dismissible(
      key: Key(item.productId),
      direction: DismissDirection.endToStart,
      background: _buildDismissBackground(r),
      onDismissed: (_) {
        context.read<CartCubit>().removeItem(item.productId);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                '${item.getName(isArabic)} ${'removed_from_cart'.tr(context)}'),
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.orange,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: r.spacing(12)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
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
              borderRadius:
                  const BorderRadius.horizontal(left: Radius.circular(18)),
              child: CachedNetworkImage(
                imageUrl: item.imageUrl,
                width: 100,
                height: 130,
                fit: BoxFit.cover,
                memCacheHeight: 300,
                placeholder: (_, __) => Container(
                  color: Colors.grey.shade100,
                  child: const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                errorWidget: (_, __, ___) => Container(
                  color: Colors.grey.shade100,
                  child: Icon(Icons.image_not_supported,
                      color: Colors.grey.shade400),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(r.spacing(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.getName(isArabic),
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
                      item.merchant,
                      style: GoogleFonts.cairo(
                        fontSize: r.fontSize(12),
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: r.spacing(12)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${item.total.toStringAsFixed(0)}',
                          style: GoogleFonts.cairo(
                            fontSize: r.fontSize(18),
                            fontWeight: FontWeight.w900,
                            color: AppColors.primary,
                          ),
                        ),
                        _buildQuantitySelector(context, r),
                      ],
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

  Widget _buildQuantitySelector(BuildContext context, Responsive r) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              item.quantity == 1
                  ? Icons.delete_outline
                  : Icons.remove_circle_outline,
              color: item.quantity == 1 ? AppColors.error : AppColors.primary,
              size: 22,
            ),
            onPressed: () {
              if (item.quantity == 1) {
                context.read<CartCubit>().removeItem(item.productId);
              } else {
                context
                    .read<CartCubit>()
                    .updateQuantity(item.productId, item.quantity - 1);
              }
            },
            padding: EdgeInsets.all(r.spacing(4)),
            constraints: const BoxConstraints(),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: r.spacing(12)),
            child: Text(
              '${item.quantity}',
              style: GoogleFonts.cairo(
                fontSize: r.fontSize(16),
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add_circle_outline,
                color: AppColors.primary, size: 22),
            onPressed: () {
              context
                  .read<CartCubit>()
                  .updateQuantity(item.productId, item.quantity + 1);
            },
            padding: EdgeInsets.all(r.spacing(4)),
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildDismissBackground(Responsive r) {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: r.spacing(20)),
      margin: EdgeInsets.only(bottom: r.spacing(12)),
      decoration: BoxDecoration(
        color: AppColors.error,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Icon(
        Icons.delete_outline,
        color: Colors.white,
        size: r.responsive(mobile: 28, tablet: 32, desktop: 36),
      ),
    );
  }
}
