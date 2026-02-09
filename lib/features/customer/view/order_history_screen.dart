import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../data/services/checkout_service.dart';
import '../data/models/order_model.dart';
import '../widgets/orders/orders_header.dart';
import '../widgets/orders/orders_tabs.dart';
import '../widgets/orders/order_card.dart';
import '../widgets/orders/orders_empty_state.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order> _allOrders = [];
  String _selectedTab = 'all';

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    final service = await CheckoutService.getInstance();
    final orders = await service.getOrders();
    setState(() {
      _allOrders = orders;
    });
  }

  List<Order> get _filteredOrders {
    if (_selectedTab == 'all') return _allOrders;
    if (_selectedTab == 'delivered') {
      return _allOrders.where((o) => o.status == 'delivered').toList();
    }
    return _allOrders
        .where((o) => o.status != 'delivered' && o.status != 'cancelled')
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const OrdersHeader(),
            OrdersTabs(
              selectedTab: _selectedTab,
              onTabChanged: (tab) => setState(() => _selectedTab = tab),
              orderCounts: {
                'all': _allOrders.length,
                'active': _allOrders
                    .where((o) =>
                        o.status != 'delivered' && o.status != 'cancelled')
                    .length,
                'delivered':
                    _allOrders.where((o) => o.status == 'delivered').length,
              },
            ),
            Expanded(
              child: _filteredOrders.isEmpty
                  ? OrdersEmptyState(selectedTab: _selectedTab)
                  : ListView.builder(
                      padding: EdgeInsets.all(r.spacing(16)),
                      physics: const BouncingScrollPhysics(),
                      itemCount: _filteredOrders.length,
                      itemBuilder: (context, index) {
                        return OrderCard(order: _filteredOrders[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
