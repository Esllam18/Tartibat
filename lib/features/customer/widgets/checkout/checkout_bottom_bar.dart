import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/localization/app_localizations.dart';
import 'payment_processing_dialog.dart';
import '../../view/order_success_screen.dart';

class CheckoutBottomBar extends StatelessWidget {
  final int totalPrice;

  const CheckoutBottomBar({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Container(
      padding: EdgeInsets.all(r.spacing(AppDimensions.paddingMedium)),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowMedium,
            blurRadius: 20,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTotalRow(context, r),
            SizedBox(height: r.spacing(16)),
            _buildPayButton(context, r),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalRow(BuildContext context, Responsive r) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'total_amount'.tr(context),
          style: AppTextStyles.h4(context),
        ),
        Text(
          '$totalPrice ${'iqd'.tr(context)}',
          style: AppTextStyles.h3(context).copyWith(
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildPayButton(BuildContext context, Responsive r) {
    return SizedBox(
      width: double.infinity,
      height: r.responsive(mobile: 56, tablet: 60, desktop: 64),
      child: ElevatedButton(
        onPressed: () => _handlePayment(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock, size: 20),
            SizedBox(width: r.spacing(8)),
            Text(
              'pay_now'.tr(context),
              style: AppTextStyles.buttonStatic,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handlePayment(BuildContext context) async {
    // Show processing dialog
    PaymentProcessingDialog.show(context);

    // Simulate payment processing
    await Future.delayed(const Duration(seconds: 2));

    if (!context.mounted) return;

    // Close processing dialog
    Navigator.pop(context);

    // Navigate to success screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => OrderSuccessScreen(
          orderNumber: 'ORD-${DateTime.now().millisecondsSinceEpoch}',
          totalAmount: totalPrice,
        ),
      ),
    );
  }
}
