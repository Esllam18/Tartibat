import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/localization/app_localizations.dart';

class FavoritesEmptyState extends StatelessWidget {
  const FavoritesEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

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
              Icons.favorite_border_rounded,
              size: r.responsive(mobile: 80, tablet: 100, desktop: 120),
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: r.spacing(24)),
          Text(
            'no_favorites_yet'.tr(context),
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
              'start_adding_favorites'.tr(context),
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
    );
  }
}
