import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/localization/app_localizations.dart';

class CheckoutPaymentSection extends StatelessWidget {
  const CheckoutPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(r.spacing(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'payment_method'.tr(context),
              style: GoogleFonts.cairo(
                fontSize: r.fontSize(18),
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: r.spacing(16)),
            Container(
              padding: EdgeInsets.all(r.spacing(16)),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primary, width: 2),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.radio_button_checked,
                    color: AppColors.primary,
                  ),
                  SizedBox(width: r.spacing(12)),
                  Container(
                    padding: EdgeInsets.all(r.spacing(10)),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.credit_card,
                      color: AppColors.primary,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: r.spacing(12)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'credit_card'.tr(context),
                          style: GoogleFonts.cairo(
                            fontSize: r.fontSize(15),
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: r.spacing(4)),
                        Text(
                          'secure_payment'.tr(context),
                          style: GoogleFonts.cairo(
                            fontSize: r.fontSize(12),
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.lock_outline, color: AppColors.success, size: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
