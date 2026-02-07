import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/utils/responsive.dart';
import 'product_status_chip.dart';
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
    final r = context.responsive;

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
          _buildImage(context, r),
          _buildContent(context, r),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context, Responsive r) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppDimensions.radiusLarge),
          ),
          child: Image.network(
            product['image'] as String,
            width: double.infinity,
            height: r.responsive(mobile: 140, tablet: 160, desktop: 180),
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              height: r.responsive(mobile: 140, tablet: 160, desktop: 180),
              color: AppColors.background,
              child: const Icon(
                Icons.image_not_supported,
                size: 50,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ),
        // Status badge
        Positioned(
          top: 10,
          left: 10,
          child: ProductStatusChip(
            status: product['status'] ?? 'pending',
          ),
        ),
        // Action buttons
        Positioned(
          top: 10,
          right: 10,
          child: _buildActionButtons(context),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        _ActionButton(
          icon: Icons.edit,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => EditProductScreen(product: product),
            ),
          ),
        ),
        const SizedBox(width: 8),
        _ActionButton(
          icon: Icons.delete,
          color: AppColors.error,
          onTap: () => _confirmDelete(context),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context, Responsive r) {
    return Padding(
      padding: EdgeInsets.all(r.spacing(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product['name'] as String,
            style: GoogleFonts.cairo(
              fontSize: r.fontSize(14),
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: r.spacing(8)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${product['price']} IQD',
                style: GoogleFonts.cairo(
                  fontSize: r.fontSize(13),
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Stock: ${product['stock']}',
                  style: GoogleFonts.cairo(
                    fontSize: r.fontSize(11),
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Icon(Icons.warning, color: AppColors.error, size: 48),
        content: const Text(
          'Are you sure you want to delete this product?',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              onDelete?.call();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;

  const _ActionButton({
    required this.icon,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowMedium,
              blurRadius: 8,
            ),
          ],
        ),
        child: Icon(
          icon,
          size: 18,
          color: color ?? AppColors.primary,
        ),
      ),
    );
  }
}
