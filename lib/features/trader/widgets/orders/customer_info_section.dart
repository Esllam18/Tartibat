import 'package:flutter/material.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/utils/responsive.dart';

class CustomerInfoSection extends StatelessWidget {
  final Map<String, dynamic> customer;

  const CustomerInfoSection({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

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
            'customer_info'.tr(context),
            style: TextStyle(
                fontSize: r.fontSize(16), fontWeight: FontWeight.bold),
          ),
          SizedBox(height: r.spacing(12)),
          _buildInfoRow(context, Icons.person, 'name'.tr(context),
              customer['name'] ?? '', r),
          SizedBox(height: r.spacing(8)),
          _buildInfoRow(context, Icons.phone, 'phone'.tr(context),
              customer['phone'] ?? '', r),
          SizedBox(height: r.spacing(8)),
          _buildInfoRow(context, Icons.location_on, 'address'.tr(context),
              customer['address'] ?? '', r),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String label,
      String value, Responsive r) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.black54),
        SizedBox(width: r.spacing(8)),
        Text('$label: ',
            style: TextStyle(fontSize: r.fontSize(14), color: Colors.black54)),
        Expanded(
          child: Text(value,
              style: TextStyle(
                  fontSize: r.fontSize(14), fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}
