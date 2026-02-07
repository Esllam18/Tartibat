import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/app_localizations.dart';
import 'dashboard_stat_card.dart';

class DashboardStatsGrid extends StatelessWidget {
  final int totalRevenue;
  final int totalOrders;
  final int totalProducts;
  final int totalCustomers;

  const DashboardStatsGrid({
    super.key,
    required this.totalRevenue,
    required this.totalOrders,
    required this.totalProducts,
    required this.totalCustomers,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.5,
      children: [
        DashboardStatCard(
          icon: Icons.attach_money,
          title: 'total_revenue'.tr(context),
          value: '${(totalRevenue / 1000).toStringAsFixed(0)}K',
          color: AppColors.success,
          subtitle: '+12%',
        ),
        DashboardStatCard(
          icon: Icons.shopping_bag_outlined,
          title: 'total_orders'.tr(context),
          value: '$totalOrders',
          color: AppColors.primary,
          subtitle: '+8%',
        ),
        DashboardStatCard(
          icon: Icons.inventory_2_outlined,
          title: 'total_products'.tr(context),
          value: '$totalProducts',
          color: AppColors.warning,
        ),
        DashboardStatCard(
          icon: Icons.people_outline,
          title: 'total_customers'.tr(context),
          value: '$totalCustomers',
          color: AppColors.info,
        ),
      ],
    );
  }
}
