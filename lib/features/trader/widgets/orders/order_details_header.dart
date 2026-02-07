import 'package:flutter/material.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/utils/responsive.dart';

class OrderDetailsHeader extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderDetailsHeader({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Container(
      padding: EdgeInsets.all(r.spacing(16)),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('order_date'.tr(context),
                  style: TextStyle(fontSize: r.fontSize(14))),
              Text(order['date'] ?? '',
                  style: TextStyle(
                      fontSize: r.fontSize(14), fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: r.spacing(12)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('total_amount'.tr(context),
                  style: TextStyle(fontSize: r.fontSize(14))),
              Text(
                '${order['total']} ${'iqd'.tr(context)}',
                style: TextStyle(
                    fontSize: r.fontSize(18), fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
