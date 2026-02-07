import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/app_localizations.dart';
import 'admin_stat_card.dart';

class AdminStatsGrid extends StatelessWidget {
  final int totalTraders;
  final int totalProducts;
  final int totalOrders;
  final int totalRevenue;

  const AdminStatsGrid({
    super.key,
    required this.totalTraders,
    required this.totalOrders,
    required this.totalProducts,
    required this.totalRevenue,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.6,
      children: [
        AdminStatCard(
          icon: Icons.store,
          title: 'total_traders'.tr(context),
          value: '$totalTraders',
          color: AppColors.primary,
        ),
        AdminStatCard(
          icon: Icons.inventory,
          title: 'total_products'.tr(context),
          value: '$totalProducts',
          color: AppColors.warning,
        ),
        AdminStatCard(
          icon: Icons.shopping_bag,
          title: 'total_orders'.tr(context),
          value: '$totalOrders',
          color: AppColors.info,
        ),
        AdminStatCard(
          icon: Icons.attach_money,
          title: 'total_revenue'.tr(context),
          value: '${(totalRevenue / 1000000).toStringAsFixed(1)}M',
          color: AppColors.success,
        ),
      ],
    );
  }
}
