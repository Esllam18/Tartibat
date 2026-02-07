import 'package:flutter/material.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/localization/app_localizations.dart';
import 'payment_status_badge.dart';

class OrderCardHeader extends StatelessWidget {
  final String orderNumber;
  final bool isPaid;

  const OrderCardHeader({
    super.key,
    required this.orderNumber,
    required this.isPaid,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'order_number'.tr(context),
                style: AppTextStyles.bodySmall(context),
              ),
              const SizedBox(height: 4),
              Text(
                orderNumber,
                style: AppTextStyles.bodyMedium(context).copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        PaymentStatusBadge(isPaid: isPaid),
      ],
    );
  }
}
