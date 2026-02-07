import 'package:flutter/material.dart';
import 'order_history_card.dart';

class OrderHistoryList extends StatelessWidget {
  final List<Map<String, dynamic>> orders;

  const OrderHistoryList({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return OrderHistoryCard(order: orders[index]);
      },
    );
  }
}
