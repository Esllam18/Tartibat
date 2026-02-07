import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/localization/app_localizations.dart';

class AuthAppBar extends StatelessWidget {
  const AuthAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(r.spacing(24)),
      decoration: const BoxDecoration(
        gradient: AppColors.primaryGradient,
      ),
      child: Column(
        children: [
          SizedBox(height: r.spacing(20)),
          Icon(
            Icons.shopping_bag_rounded,
            size: r.spacing(60),
            color: Colors.white,
          ),
          SizedBox(height: r.spacing(16)),
          Text(
            'welcome_back'.tr(context),
            style: GoogleFonts.cairo(
              fontSize: r.fontSize(28),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: r.spacing(8)),
          Text(
            'login_or_register'.tr(context),
            style: GoogleFonts.cairo(
              fontSize: r.fontSize(16),
              color: Colors.white70,
            ),
          ),
          SizedBox(height: r.spacing(20)),
        ],
      ),
    );
  }
}
