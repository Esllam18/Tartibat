import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../view/checkout_screen.dart';

class CartCheckout extends StatelessWidget {
  final int totalPrice;
  final List<Map<String, dynamic>> cartItems;

  const CartCheckout({
    super.key,
    required this.totalPrice,
    required this.cartItems,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppDimensions.radiusXLarge)),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowMedium,
            blurRadius: 20,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('total'.tr(context), style: AppTextStyles.h4(context)),
              Text('$totalPrice ${'egp'.tr(context)}',
                  style: AppTextStyles.price(context)),
            ],
          ),
          const SizedBox(height: AppDimensions.paddingMedium),
          SizedBox(
            width: double.infinity,
            height: AppDimensions.buttonHeight,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CheckoutScreen(
                      cartItems: cartItems,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusLarge),
                ),
                elevation: 0,
              ),
              child: Text('checkout'.tr(context),
                  style: AppTextStyles.buttonStatic),
            ),
          ),
        ],
      ),
    );
  }
}
