import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/responsive.dart';
import '../../../../../core/localization/app_localizations.dart';

class ProductDetailsAppBar extends StatelessWidget {
  final String imageUrl;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const ProductDetailsAppBar({
    super.key,
    required this.imageUrl,
    required this.isFavorite,
    required this.onFavoriteToggle,
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
        _buildIconButton(
            context,
            r,
            isFavorite ? Icons.favorite : Icons.favorite_border,
            onFavoriteToggle,
            color: isFavorite ? Colors.red : null),
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
              child: Icon(Icons.image_not_supported,
                  size: 60, color: Colors.grey.shade400),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(
      BuildContext context, Responsive r, IconData icon, VoidCallback onPressed,
      {Color? color}) {
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
