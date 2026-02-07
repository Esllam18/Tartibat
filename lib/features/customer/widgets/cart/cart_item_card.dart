import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/utils/responsive.dart';

class CartItemCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final Function(int) onQuantityChanged;

  const CartItemCard({
    super.key,
    required this.item,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Container(
      margin: EdgeInsets.only(bottom: r.spacing(16)),
      padding: EdgeInsets.all(r.spacing(12)),
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
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
            child: Image.network(
              item['image'] as String,
              width: r.responsive(mobile: 80, tablet: 100, desktop: 120),
              height: r.responsive(mobile: 80, tablet: 100, desktop: 120),
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: r.responsive(mobile: 80, tablet: 100, desktop: 120),
                height: r.responsive(mobile: 80, tablet: 100, desktop: 120),
                color: AppColors.background,
                child: const Icon(Icons.image_not_supported,
                    color: AppColors.primaryLight),
              ),
            ),
          ),
          SizedBox(width: r.spacing(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'] as String,
                  style: AppTextStyles.bodyMedium(context)
                      .copyWith(fontWeight: FontWeight.bold),
                  maxLines: 2,
                ),
                SizedBox(height: r.spacing(8)),
                Text(
                  '${item['price']} جنيه',
                  style: AppTextStyles.price(context),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
            ),
            child: Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.add, color: AppColors.primary),
                  iconSize: r.responsive(mobile: 18, tablet: 20, desktop: 22),
                  onPressed: () =>
                      onQuantityChanged((item['quantity'] as int) + 1),
                  constraints: BoxConstraints(
                    minWidth: r.responsive(mobile: 32, tablet: 36, desktop: 40),
                    minHeight:
                        r.responsive(mobile: 32, tablet: 36, desktop: 40),
                  ),
                  padding: EdgeInsets.zero,
                ),
                Text(
                  '${item['quantity']}',
                  style: AppTextStyles.bodyMedium(context)
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.remove, color: AppColors.primary),
                  iconSize: r.responsive(mobile: 18, tablet: 20, desktop: 22),
                  onPressed: () {
                    if ((item['quantity'] as int) > 1) {
                      onQuantityChanged((item['quantity'] as int) - 1);
                    }
                  },
                  constraints: BoxConstraints(
                    minWidth: r.responsive(mobile: 32, tablet: 36, desktop: 40),
                    minHeight:
                        r.responsive(mobile: 32, tablet: 36, desktop: 40),
                  ),
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
