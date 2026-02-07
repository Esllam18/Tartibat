import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/localization/app_localizations.dart';
import 'order_card.dart';

class OrdersTabs extends StatefulWidget {
  const OrdersTabs({super.key});

  @override
  State<OrdersTabs> createState() => _OrdersTabsState();
}

class _OrdersTabsState extends State<OrdersTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: r.paddingHorizontal),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadowLight,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(16),
            ),
            labelColor: Colors.white,
            unselectedLabelColor: AppColors.textSecondary,
            dividerColor: Colors.transparent,
            labelStyle: TextStyle(
                fontSize: r.fontSize(14), fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: 'new'.tr(context)),
              Tab(text: 'preparing'.tr(context)),
              Tab(text: 'shipped'.tr(context)),
              Tab(text: 'delivered'.tr(context)),
            ],
          ),
        ),
        SizedBox(height: r.spacing(16)),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildOrdersList('new'),
              _buildOrdersList('preparing'),
              _buildOrdersList('shipped'),
              _buildOrdersList('delivered'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOrdersList(String status) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: 5,
      itemBuilder: (context, index) =>
          TraderOrderCard(index: index, status: status),
    );
  }
}
