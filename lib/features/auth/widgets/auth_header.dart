import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/localization/app_localizations.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(r.spacing(20)),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Icon(
            Icons.shopping_bag_rounded,
            size: r.responsive(mobile: 60, tablet: 75, desktop: 85),
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: r.spacing(24)),
        Text(
          'welcome_to_tartibat'.tr(context),
          style: GoogleFonts.cairo(
            fontSize: r.fontSize(32),
            fontWeight: FontWeight.w900,
            color: AppColors.textPrimary,
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: r.spacing(10)),
        Text(
          'auth_subtitle'.tr(context),
          style: GoogleFonts.cairo(
            fontSize: r.fontSize(16),
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondary,
            height: 1.4,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
