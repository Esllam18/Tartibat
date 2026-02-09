import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tartibat/features/customer/data/bloc/favorites_cubit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../data/models/favorite_model.dart';
import '../../view/product_details_screen.dart';

class FavoriteCard extends StatelessWidget {
  final FavoriteModel favorite;

  const FavoriteCard({super.key, required this.favorite});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Dismissible(
      key: Key(favorite.id),
      direction: DismissDirection.endToStart,
      background: _buildDismissBackground(r),
      onDismissed: (_) {
        context.read<FavoritesCubit>().removeFavorite(favorite.id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${favorite.getName(isArabic)} ${'removed_from_favorites'.tr(context)}',
            ),
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.orange,
          ),
        );
      },
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailsScreen(
              product: {
                'id': favorite.id,
                'name': favorite.getName(isArabic),
                'price': favorite.price,
                'image': favorite.imageUrl,
                'location': favorite.merchant,
              },
            ),
          ),
        ),
        child: Container(
          height: 120,
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
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(18),
                ),
                child: CachedNetworkImage(
                  imageUrl: favorite.imageUrl,
                  width: 120,
                  height: 120,
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
                    child: Icon(
                      Icons.image_not_supported,
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
                      Text(
                        favorite.getName(isArabic),
                        style: GoogleFonts.cairo(
                          fontSize: r.fontSize(15),
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        favorite.merchant,
                        style: GoogleFonts.cairo(
                          fontSize: r.fontSize(13),
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: r.spacing(12),
                              vertical: r.spacing(6),
                            ),
                            decoration: BoxDecoration(
                              gradient: AppColors.primaryGradient,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '\$${favorite.price.toStringAsFixed(0)}',
                              style: GoogleFonts.cairo(
                                fontSize: r.fontSize(14),
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 20,
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
