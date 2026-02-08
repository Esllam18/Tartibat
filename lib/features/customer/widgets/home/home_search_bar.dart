import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tartibat/features/customer/view/search_screen.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/localization/app_localizations.dart';

class HomeSearchBar extends StatelessWidget {
  final VoidCallback? onFilterTap;

  const HomeSearchBar({super.key, this.onFilterTap});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: r.spacing(16),
        vertical: r.spacing(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchScreen()),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: r.spacing(18),
                  vertical: r.spacing(16),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search_rounded,
                      color: AppColors.primary,
                      size: r.responsive(mobile: 24, tablet: 26, desktop: 28),
                    ),
                    SizedBox(width: r.spacing(14)),
                    Expanded(
                      child: Text(
                        'search_furniture'.tr(context),
                        style: GoogleFonts.cairo(
                          fontSize: r.fontSize(15),
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: r.spacing(12)),
          GestureDetector(
            onTap: onFilterTap,
            child: Container(
              padding: EdgeInsets.all(r.spacing(16)),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.tune_rounded,
                color: Colors.white,
                size: r.responsive(mobile: 24, tablet: 26, desktop: 28),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
