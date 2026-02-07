import 'package:flutter/material.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/utils/responsive.dart';

class CartTotalBottom extends StatelessWidget {
  final int totalPrice;
  final VoidCallback onCheckout;

  const CartTotalBottom({
    super.key,
    required this.totalPrice,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Container(
      padding: EdgeInsets.all(r.spacing(20)),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'total'.tr(context),
                  style: TextStyle(
                      fontSize: r.fontSize(18), fontWeight: FontWeight.w600),
                ),
                Text(
                  '$totalPrice ${'iqd'.tr(context)}',
                  style: TextStyle(
                    fontSize: r.fontSize(22),
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: r.spacing(16)),
            SizedBox(
              width: double.infinity,
              height: r.responsive(mobile: 54, tablet: 60, desktop: 64),
              child: ElevatedButton(
                onPressed: onCheckout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  'checkout'.tr(context),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: r.fontSize(16),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
