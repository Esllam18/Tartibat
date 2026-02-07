import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/loading_state.dart';
import '../../../core/localization/app_localizations.dart';
import '../widgets/orders/trader_order_card.dart';
import '../widgets/orders/orders_empty.dart';

class TraderOrdersScreen extends StatefulWidget {
  const TraderOrdersScreen({super.key});

  @override
  State<TraderOrdersScreen> createState() => _TraderOrdersScreenState();
}

class _TraderOrdersScreenState extends State<TraderOrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(context),
      body: _isLoading
          ? const LoadingState()
          : TabBarView(
              controller: _tabController,
              children: const [
                _OrdersList(status: 'new'),
                _OrdersList(status: 'preparing'),
                _OrdersList(status: 'shipped'),
                _OrdersList(status: 'delivered'),
              ],
            ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      title: Text('orders'.tr(context), style: AppTextStyles.h3(context)),
      centerTitle: true,
      bottom: TabBar(
        controller: _tabController,
        indicatorColor: AppColors.primary,
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textSecondary,
        tabs: [
          Tab(text: 'new'.tr(context)),
          Tab(text: 'preparing'.tr(context)),
          Tab(text: 'shipped'.tr(context)),
          Tab(text: 'delivered'.tr(context)),
        ],
      ),
    );
  }
}

class _OrdersList extends StatelessWidget {
  final String status;

  const _OrdersList({required this.status});

  @override
  Widget build(BuildContext context) {
    // Mock data - replace with real data
    final orders = <Map<String, dynamic>>[];

    return orders.isEmpty
        ? const OrdersEmpty()
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: orders.length,
            itemBuilder: (_, i) => TraderOrderCard(index: i, status: status),
          );
  }
}
