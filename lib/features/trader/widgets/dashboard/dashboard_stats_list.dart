import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/app_localizations.dart';
import 'dashboard_stat_card_compact.dart';

class DashboardStatsList extends StatelessWidget {
  final int totalRevenue;
  final int totalOrders;
  final int totalProducts;
  final int totalCustomers;

  const DashboardStatsList({
    super.key,
    required this.totalRevenue,
    required this.totalOrders,
    required this.totalProducts,
    required this.totalCustomers,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DashboardStatCardCompact(
          icon: Icons.attach_money,
          title: 'total_revenue'.tr(context),
          value: '${(totalRevenue / 1000).toStringAsFixed(0)}K IQD',
          color: AppColors.success,
        ),
        const SizedBox(height: 12),
        DashboardStatCardCompact(
          icon: Icons.shopping_bag_outlined,
          title: 'total_orders'.tr(context),
          value: '$totalOrders',
          color: AppColors.primary,
        ),
        const SizedBox(height: 12),
        DashboardStatCardCompact(
          icon: Icons.inventory_2_outlined,
          title: 'total_products'.tr(context),
          value: '$totalProducts',
          color: AppColors.warning,
        ),
        const SizedBox(height: 12),
        DashboardStatCardCompact(
          icon: Icons.people_outline,
          title: 'total_customers'.tr(context),
          value: '$totalCustomers',
          color: AppColors.info,
        ),
      ],
    );
  }
}
