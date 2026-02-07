import 'package:flutter/material.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/utils/responsive.dart';
import '../widgets/orders/orders_app_bar.dart';
import '../widgets/orders/order_card_trader.dart';

class TraderOrdersScreen extends StatefulWidget {
  const TraderOrdersScreen({super.key});

  @override
  State<TraderOrdersScreen> createState() => _TraderOrdersScreenState();
}

class _TraderOrdersScreenState extends State<TraderOrdersScreen> {
  final List<Map<String, dynamic>> _orders = [];

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const OrdersAppBar(),
      body: _orders.isEmpty
          ? EmptyState(
              icon: Icons.shopping_bag_outlined,
              title: 'no_orders'.tr(context),
              message: 'no_orders_message'.tr(context),
            )
          : ListView.builder(
              padding: EdgeInsets.all(r.spacing(16)),
              itemCount: _orders.length,
              itemBuilder: (context, index) {
                return OrderCardTrader(order: _orders[index]);
              },
            ),
    );
  }
}
