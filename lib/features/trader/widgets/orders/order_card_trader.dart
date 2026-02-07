import 'package:flutter/material.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/utils/responsive.dart';
import '../../view/order_details_screen.dart';
import 'order_status_badge.dart';

class OrderCardTrader extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderCardTrader({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Container(
      margin: EdgeInsets.only(bottom: r.spacing(12)),
      padding: EdgeInsets.all(r.spacing(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${'order'.tr(context)} #${order['id'] ?? 'N/A'}',
                style: TextStyle(
                    fontSize: r.fontSize(16), fontWeight: FontWeight.bold),
              ),
              OrderStatusBadge(status: order['status'] ?? 'pending'),
            ],
          ),
          SizedBox(height: r.spacing(12)),
          Row(
            children: [
              const Icon(Icons.person, size: 16, color: Colors.black54),
              SizedBox(width: r.spacing(4)),
              Text(order['customer'] ?? '',
                  style: TextStyle(fontSize: r.fontSize(14))),
            ],
          ),
          SizedBox(height: r.spacing(12)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                order['date'] ?? '',
                style:
                    TextStyle(fontSize: r.fontSize(12), color: Colors.black54),
              ),
              Text(
                '${order['total']} ${'iqd'.tr(context)}',
                style: TextStyle(
                    fontSize: r.fontSize(16), fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: r.spacing(12)),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => _viewDetails(context),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.black),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: Text('view_details'.tr(context),
                  style: const TextStyle(color: Colors.black)),
            ),
          ),
        ],
      ),
    );
  }

  void _viewDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => OrderDetailsScreen(order: order)),
    );
  }
}
