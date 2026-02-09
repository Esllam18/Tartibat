import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tartibat/features/customer/data/bloc/cart_cubit.dart';
import 'package:tartibat/features/customer/data/bloc/favorites_cubit.dart';
import 'package:tartibat/features/customer/data/bloc/favorites_state.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../data/models/product_model.dart';

import '../../view/product_details_screen.dart';

class ProductCardGrid extends StatelessWidget {
  final Product product;

  const ProductCardGrid({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return BlocListener<FavoritesCubit, FavoritesState>(
      listenWhen: (previous, current) {
        // Only listen if the state actually changed from non-success to success
        return (previous is! FavoriteAddedSuccess &&
                current is FavoriteAddedSuccess) ||
            (previous is! FavoriteRemovedSuccess &&
                current is FavoriteRemovedSuccess);
      },
      listener: (context, state) {
        if (state is FavoriteAddedSuccess) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.favorite, color: Colors.white, size: 20),
                  SizedBox(width: r.spacing(12)),
                  Expanded(
                    child: Text('added_to_favorites'.tr(context)),
                  ),
                ],
              ),
              backgroundColor: AppColors.success,
              duration: const Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        } else if (state is FavoriteRemovedSuccess) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.favorite_border,
                      color: Colors.white, size: 20),
                  SizedBox(width: r.spacing(12)),
                  Expanded(
                    child: Text('removed_from_favorites'.tr(context)),
                  ),
                ],
              ),
              backgroundColor: Colors.orange,
              duration: const Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        }
      },
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: context.read<FavoritesCubit>(),
              child: BlocProvider.value(
                value: context.read<CartCubit>(),
                child: ProductDetailsScreen(
                  product: {
                    'id': product.id,
                    'name': product.getName(isArabic),
                    'price': product.price,
                    'image': product.imageUrl,
                    'location': product.merchant,
                  },
                  productModel: product,
                ),
              ),
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
              Expanded(flex: 10, child: _buildImage(context, r)),
              Padding(
                padding: EdgeInsets.all(r.spacing(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.getName(isArabic),
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
                      product.merchant,
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
                        '\$${product.price.toStringAsFixed(0)}',
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
      ),
    );
  }

  Widget _buildImage(BuildContext context, Responsive r) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: CachedNetworkImage(
            imageUrl: product.imageUrl,
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
          child: BlocBuilder<FavoritesCubit, FavoritesState>(
            buildWhen: (previous, current) => current is FavoritesLoaded,
            builder: (context, state) {
              final isFav = state is FavoritesLoaded
                  ? state.isFavorite(product.id)
                  : false;

              return GestureDetector(
                onTap: () {
                  context.read<FavoritesCubit>().toggleFavorite(product);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: EdgeInsets.all(r.spacing(6)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(isFav ? 0.15 : 0.1),
                        blurRadius: isFav ? 12 : 8,
                      ),
                    ],
                  ),
                  child: Icon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    size: 16,
                    color: isFav ? Colors.red : Colors.grey.shade600,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
