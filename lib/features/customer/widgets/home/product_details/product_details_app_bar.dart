import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tartibat/core/constants/app_colors.dart';
import 'package:tartibat/core/localization/app_localizations.dart';
import 'package:tartibat/core/utils/responsive.dart';
import 'package:tartibat/features/customer/data/bloc/favorites_cubit.dart';
import 'package:tartibat/features/customer/data/bloc/favorites_state.dart';
import 'package:tartibat/features/customer/data/models/product_model.dart';

class ProductDetailsAppBar extends StatelessWidget {
  final String imageUrl;
  final String productId;
  final Product? productModel;

  const ProductDetailsAppBar({
    super.key,
    required this.imageUrl,
    required this.productId,
    this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return SliverAppBar(
      expandedHeight: r.responsive(mobile: 320, tablet: 380, desktop: 450),
      pinned: true,
      backgroundColor: Colors.white,
      elevation: 0,
      leading: _buildIconButton(
        context,
        r,
        Icons.arrow_back,
        () => Navigator.pop(context),
      ),
      actions: [
        if (productModel != null)
          BlocBuilder<FavoritesCubit, FavoritesState>(
            builder: (context, state) {
              final isFav = state is FavoritesLoaded
                  ? state.isFavorite(productId)
                  : false;

              return _buildIconButton(
                context,
                r,
                isFav ? Icons.favorite : Icons.favorite_border,
                () {
                  if (productModel != null) {
                    context
                        .read<FavoritesCubit>()
                        .toggleFavorite(productModel!);
                  }
                },
                color: isFav ? Colors.red : null,
              );
            },
          ),
        _buildIconButton(context, r, Icons.share_outlined, () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('share_product'.tr(context))),
          );
        }),
        SizedBox(width: r.spacing(8)),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: 'product_$imageUrl',
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            memCacheHeight: 800,
            placeholder: (_, __) => Container(
              color: Colors.grey.shade100,
              child: const Center(child: CircularProgressIndicator()),
            ),
            errorWidget: (_, __, ___) => Container(
              color: Colors.grey.shade100,
              child: Icon(
                Icons.image_not_supported,
                size: 60,
                color: Colors.grey.shade400,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(
    BuildContext context,
    Responsive r,
    IconData icon,
    VoidCallback onPressed, {
    Color? color,
  }) {
    return IconButton(
      icon: Container(
        padding: EdgeInsets.all(r.spacing(8)),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
            ),
          ],
        ),
        child: Icon(icon, color: color ?? AppColors.textPrimary, size: 20),
      ),
      onPressed: onPressed,
    );
  }
}
