import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/utils/responsive.dart';
import 'product_status_chip.dart';
import 'product_action_button.dart';

class ProductCardImage extends StatelessWidget {
  final String imageUrl;
  final String status;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ProductCardImage({
    super.key,
    required this.imageUrl,
    required this.status,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppDimensions.radiusLarge),
          ),
          child: Image.network(
            imageUrl,
            width: double.infinity,
            height: r.responsive(mobile: 140, tablet: 160, desktop: 180),
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => _buildErrorPlaceholder(r),
          ),
        ),
        Positioned(
          top: 10,
          left: 10,
          child: ProductStatusChip(status: status),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: _buildActions(),
        ),
      ],
    );
  }

  Widget _buildErrorPlaceholder(Responsive r) {
    return Container(
      height: r.responsive(mobile: 140, tablet: 160, desktop: 180),
      color: AppColors.background,
      child: const Icon(
        Icons.image_not_supported,
        size: 50,
        color: AppColors.textSecondary,
      ),
    );
  }

  Widget _buildActions() {
    return Row(
      children: [
        ProductActionButton(icon: Icons.edit, onTap: onEdit),
        const SizedBox(width: 8),
        ProductActionButton(
          icon: Icons.delete,
          color: AppColors.error,
          onTap: onDelete,
        ),
      ],
    );
  }
}
