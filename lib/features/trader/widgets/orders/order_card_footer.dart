import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/localization/app_localizations.dart';

class OrderCardFooter extends StatelessWidget {
  final int totalAmount;
  final String status;
  final VoidCallback onViewDetails;

  const OrderCardFooter({
    super.key,
    required this.totalAmount,
    required this.status,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'total_amount'.tr(context),
              style: AppTextStyles.bodySmall(context),
            ),
            const SizedBox(height: 4),
            Text(
              '$totalAmount ${'iqd'.tr(context)}',
              style: AppTextStyles.h4(context).copyWith(
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        OutlinedButton(
          onPressed: onViewDetails,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            side: const BorderSide(color: AppColors.primary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text('view_details'.tr(context)),
        ),
      ],
    );
  }
}
