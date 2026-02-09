import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/localization/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(r.spacing(20)),
              color: Colors.white,
              child: Row(
                children: [
                  Text(
                    'profile'.tr(context),
                    style: GoogleFonts.cairo(
                      fontSize: r.fontSize(26),
                      fontWeight: FontWeight.w900,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
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
                        Icons.person_outline,
                        size:
                            r.responsive(mobile: 80, tablet: 100, desktop: 120),
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: r.spacing(24)),
                    Text(
                      'profile_coming_soon'.tr(context),
                      style: GoogleFonts.cairo(
                        fontSize: r.fontSize(22),
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: r.spacing(12)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: r.spacing(40)),
                      child: Text(
                        'profile_feature_description'.tr(context),
                        style: GoogleFonts.cairo(
                          fontSize: r.fontSize(15),
                          color: AppColors.textSecondary,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
