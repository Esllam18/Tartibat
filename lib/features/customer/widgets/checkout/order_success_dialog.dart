import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tartibat/features/customer/view/order_history_screen.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../data/models/order_model.dart';

class OrderSuccessDialog extends StatelessWidget {
  final Order order;

  const OrderSuccessDialog({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        padding: EdgeInsets.all(r.spacing(24)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: r.responsive(mobile: 120, tablet: 140, desktop: 160),
              height: r.responsive(mobile: 120, tablet: 140, desktop: 160),
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle,
                color: AppColors.success,
                size: r.responsive(mobile: 60, tablet: 70, desktop: 80),
              ),
            ),
            SizedBox(height: r.spacing(24)),
            Text(
              'order_placed_successfully'.tr(context),
              style: GoogleFonts.cairo(
                fontSize: r.fontSize(22),
                fontWeight: FontWeight.w900,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: r.spacing(12)),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: r.spacing(16),
                vertical: r.spacing(8),
              ),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${'order_id'.tr(context)}: #${order.id.substring(order.id.length - 6)}',
                style: GoogleFonts.cairo(
                  fontSize: r.fontSize(14),
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ),
            SizedBox(height: r.spacing(16)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: r.spacing(8)),
              child: Text(
                'order_confirmation_message'.tr(context),
                style: GoogleFonts.cairo(
                  fontSize: r.fontSize(14),
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: r.spacing(24)),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: r.spacing(14)),
                      side: BorderSide(color: AppColors.primary, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      'continue_shopping'.tr(context),
                      style: GoogleFonts.cairo(
                        fontSize: r.fontSize(15),
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: r.spacing(12)),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close dialog
                      Navigator.pop(context); // Close checkout
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const OrdersScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: EdgeInsets.symmetric(vertical: r.spacing(14)),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      'view_orders'.tr(context),
                      style: GoogleFonts.cairo(
                        fontSize: r.fontSize(15),
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
