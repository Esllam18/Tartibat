import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/localization/app_localizations.dart';
import 'quick_action_button.dart';

class QuickActions extends StatelessWidget {
  final VoidCallback onAddProduct;
  final VoidCallback onViewOrders;
  final VoidCallback onViewProducts;

  const QuickActions({
    super.key,
    required this.onAddProduct,
    required this.onViewOrders,
    required this.onViewProducts,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'quick_actions'.tr(context),
          style: AppTextStyles.h4(context),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: QuickActionButton(
                icon: Icons.add_circle_outline,
                label: 'add_product'.tr(context),
                color: AppColors.primary,
                onTap: onAddProduct,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: QuickActionButton(
                icon: Icons.receipt_long,
                label: 'view_orders'.tr(context),
                color: AppColors.success,
                onTap: onViewOrders,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: QuickActionButton(
                icon: Icons.inventory_2,
                label: 'view_products'.tr(context),
                color: AppColors.warning,
                onTap: onViewProducts,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
