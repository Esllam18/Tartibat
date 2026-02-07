import 'package:flutter/material.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/utils/responsive.dart';

class OrderStatusBadge extends StatelessWidget {
  final String status;

  const OrderStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final config = _getStatusConfig(status);

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: r.spacing(12), vertical: r.spacing(6)),
      decoration: BoxDecoration(
        color: config['color'].withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: config['color']),
      ),
      child: Text(
        status.tr(context),
        style: TextStyle(
          color: config['color'],
          fontSize: r.fontSize(12),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Map<String, dynamic> _getStatusConfig(String status) {
    switch (status) {
      case 'preparing':
        return {'color': Colors.orange};
      case 'shipped':
        return {'color': Colors.blue};
      case 'delivered':
        return {'color': Colors.green};
      default:
        return {'color': Colors.grey};
    }
  }
}
