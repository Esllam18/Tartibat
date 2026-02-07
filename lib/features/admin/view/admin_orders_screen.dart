import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/localization/app_localizations.dart';
import '../widgets/common/admin_app_bar.dart';
import '../widgets/orders/admin_order_card.dart';

class AdminOrdersScreen extends StatelessWidget {
  const AdminOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data - replace with real data
    final orders = <Map<String, dynamic>>[];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AdminAppBar(title: 'orders'.tr(context)),
      body: orders.isEmpty
          ? EmptyState(
              icon: Icons.shopping_bag_outlined,
              title: 'no_orders'.tr(context),
              message: 'no_orders_message'.tr(context),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return AdminOrderCard(order: orders[index]);
              },
            ),
    );
  }
}
