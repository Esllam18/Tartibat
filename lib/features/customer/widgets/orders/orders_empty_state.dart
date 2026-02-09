import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/localization/app_localizations.dart';

class OrdersEmptyState extends StatelessWidget {
  final String selectedTab;

  const OrdersEmptyState({super.key, required this.selectedTab});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    String message;
    if (selectedTab == 'delivered') {
      message = 'no_delivered_orders'.tr(context);
    } else if (selectedTab == 'active') {
      message = 'no_active_orders'.tr(context);
    } else {
      message = 'no_orders_yet'.tr(context);
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(r.spacing(30)),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.shopping_bag_outlined,
              size: r.responsive(mobile: 80, tablet: 100, desktop: 120),
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: r.spacing(24)),
          Text(
            message,
            style: GoogleFonts.cairo(
              fontSize: r.fontSize(18),
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: r.spacing(12)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: r.spacing(40)),
            child: Text(
              'start_shopping_message'.tr(context),
              style: GoogleFonts.cairo(
                fontSize: r.fontSize(14),
                color: AppColors.textSecondary,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
