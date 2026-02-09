import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tartibat/features/customer/data/bloc/cart_cubit.dart';
import 'package:tartibat/features/customer/data/bloc/favorites_cubit.dart';
import 'package:tartibat/features/customer/data/bloc/favorites_state.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../data/models/product_model.dart';
import '../../view/product_details_screen.dart';

class ProductCardList extends StatelessWidget {
  final Product product;

  const ProductCardList({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: context.read<FavoritesCubit>()),
              BlocProvider.value(value: context.read<CartCubit>()),
            ],
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
      child: Container(
        height: 110,
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
                imageUrl: product.imageUrl,
                width: 110,
                height: 110,
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
                padding: EdgeInsets.symmetric(
                  horizontal: r.spacing(12),
                  vertical: r.spacing(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            product.getName(isArabic),
                            style: GoogleFonts.cairo(
                              fontSize: r.fontSize(14),
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                              height: 1.2,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: r.spacing(4)),
                        BlocBuilder<FavoritesCubit, FavoritesState>(
                          buildWhen: (previous, current) =>
                              current is FavoritesLoaded,
                          builder: (context, state) {
                            final isFav = state is FavoritesLoaded
                                ? state.isFavorite(product.id)
                                : false;

                            return GestureDetector(
                              onTap: () {
                                context
                                    .read<FavoritesCubit>()
                                    .toggleFavorite(product);
                              },
                              child: Container(
                                padding: EdgeInsets.all(r.spacing(6)),
                                child: Icon(
                                  isFav
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color:
                                      isFav ? Colors.red : Colors.grey.shade600,
                                  size: 18,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      product.merchant,
                      style: GoogleFonts.cairo(
                        fontSize: r.fontSize(11),
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: r.spacing(6)),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: r.spacing(10),
                            vertical: r.spacing(6),
                          ),
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '\$${product.price.toStringAsFixed(0)}',
                            style: GoogleFonts.cairo(
                              fontSize: r.fontSize(13),
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
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
}
