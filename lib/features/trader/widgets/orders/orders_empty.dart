import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/localization/app_localizations.dart';

class OrdersEmpty extends StatelessWidget {
  const OrdersEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.receipt_long_outlined,
                size: 100,
                color: AppColors.primary.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'no_orders'.tr(context),
              style: AppTextStyles.h3(context),
            ),
            const SizedBox(height: 12),
            Text(
              'no_orders_message'.tr(context),
              style: AppTextStyles.bodyMedium(context),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
