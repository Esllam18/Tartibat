import 'package:flutter/material.dart';
import 'package:tartibat/core/constants/app_colors.dart';
import 'package:tartibat/core/localization/app_localizations.dart';
import 'package:tartibat/features/admin/widgets/common/admin_app_bar.dart';
import 'package:tartibat/features/admin/widgets/dashboard/admin_pending_approvals.dart';
import 'package:tartibat/features/admin/widgets/dashboard/admin_recent_activity.dart';
import 'package:tartibat/features/admin/widgets/dashboard/admin_stats_grid.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AdminAppBar(title: 'dashboard'.tr(context)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const AdminStatsGrid(
              totalTraders: 156,
              totalProducts: 1240,
              totalOrders: 3456,
              totalRevenue: 45600000,
            ),
            const SizedBox(height: 24),
            const AdminPendingApprovals(
              pendingTraders: 12,
              pendingProducts: 34,
            ),
            const SizedBox(height: 24),
            AdminRecentActivity(activities: _getMockActivities()),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getMockActivities() {
    return [
      {
        'type': 'trader',
        'message': 'New trader registered',
        'time': '5 min ago'
      },
      {'type': 'product', 'message': 'Product approved', 'time': '10 min ago'},
      {'type': 'order', 'message': 'New order placed', 'time': '15 min ago'},
    ];
  }
}
