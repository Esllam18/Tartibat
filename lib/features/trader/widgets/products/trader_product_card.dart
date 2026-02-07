import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';

import 'product_card_image.dart';
import 'product_card_content.dart';
import 'product_delete_dialog.dart';
import '../../view/edit_product_screen.dart';

class TraderProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final VoidCallback? onDelete;

  const TraderProductCard({
    super.key,
    required this.product,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 15,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductCardImage(
            imageUrl: product['image'] as String,
            status: product['status'] ?? 'pending',
            onEdit: () => _navigateToEdit(context),
            onDelete: () => _confirmDelete(context),
          ),
          ProductCardContent(product: product),
        ],
      ),
    );
  }

  void _navigateToEdit(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditProductScreen(product: product),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    ProductDeleteDialog.show(context, onConfirm: onDelete);
  }
}
