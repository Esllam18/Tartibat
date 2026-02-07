import 'package:flutter/material.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/utils/responsive.dart';

class OrderStatusSection extends StatelessWidget {
  final String currentStatus;
  final Function(String) onStatusChange;

  const OrderStatusSection({
    super.key,
    required this.currentStatus,
    required this.onStatusChange,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final statuses = ['preparing', 'shipped', 'delivered'];

    return Container(
      padding: EdgeInsets.all(r.spacing(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'update_status'.tr(context),
            style: TextStyle(
                fontSize: r.fontSize(16), fontWeight: FontWeight.bold),
          ),
          SizedBox(height: r.spacing(12)),
          ...statuses.map((status) {
            return RadioListTile<String>(
              title: Text(status.tr(context)),
              value: status,
              groupValue: currentStatus,
              onChanged: (value) => onStatusChange(value!),
              activeColor: Colors.black,
              contentPadding: EdgeInsets.zero,
            );
          }),
        ],
      ),
    );
  }
}
