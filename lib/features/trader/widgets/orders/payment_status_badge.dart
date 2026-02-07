import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/app_localizations.dart';

class PaymentStatusBadge extends StatelessWidget {
  final bool isPaid;

  const PaymentStatusBadge({super.key, required this.isPaid});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isPaid
            ? AppColors.success.withOpacity(0.1)
            : AppColors.warning.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isPaid ? AppColors.success : AppColors.warning,
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isPaid ? Icons.check_circle : Icons.schedule,
            size: 14,
            color: isPaid ? AppColors.success : AppColors.warning,
          ),
          const SizedBox(width: 4),
          Text(
            isPaid ? 'paid'.tr(context) : 'pending_payment'.tr(context),
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: isPaid ? AppColors.success : AppColors.warning,
            ),
          ),
        ],
      ),
    );
  }
}
