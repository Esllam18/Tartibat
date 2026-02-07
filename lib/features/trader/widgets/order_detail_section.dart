import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/localization/app_localizations.dart';

class OrderDetailSection extends StatelessWidget {
  final Map<String, dynamic> order;
  const OrderDetailSection({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [Color(0xFF8B4513), Color(0xFFD2B48C)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        boxShadow: const [
          BoxShadow(
              color: AppColors.shadowMedium,
              blurRadius: 20,
              offset: Offset(0, 8))
        ],
      ),
      child: Column(
        children: [
          Row(children: [
            const Icon(Icons.receipt_long, color: Colors.white, size: 24),
            const SizedBox(width: 12),
            Text('order_details'.tr(context),
                style: AppTextStyles.h4(context).copyWith(color: Colors.white))
          ]),
          const SizedBox(height: 16),
          _Row('order_number'.tr(context), '#${order['id'] ?? 'N/A'}'),
          const Divider(color: Colors.white24, height: 20),
          _Row('customer'.tr(context), order['customer'] ?? 'محمد أحمد'),
          const Divider(color: Colors.white24, height: 20),
          _Row('total'.tr(context),
              '${order['total'] ?? 9000000} ${'iqd'.tr(context)}'),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String label, value;
  const _Row(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
      Text(value,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15))
    ]);
  }
}
