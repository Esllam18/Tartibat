import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/loading_state.dart';
import '../../../core/localization/app_localizations.dart';
import '../widgets/orders/order_history_list.dart';
import '../widgets/orders/order_history_app_bar.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  bool _isLoading = true;
  final List<Map<String, dynamic>> _orders = [];

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    // TODO: Load from backend
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const OrderHistoryAppBar(),
      body: _isLoading
          ? const LoadingState()
          : _orders.isEmpty
              ? EmptyState(
                  icon: Icons.shopping_bag_outlined,
                  title: 'no_orders'.tr(context),
                  message: 'no_orders_message'.tr(context),
                )
              : OrderHistoryList(orders: _orders),
    );
  }
}
