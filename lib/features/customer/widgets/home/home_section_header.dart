import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../view/products_browse_screen.dart';

class HomeSectionHeader extends StatelessWidget {
  final String title;
  final String category;

  const HomeSectionHeader({
    super.key,
    required this.title,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: r.spacing(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.cairo(
              fontSize: r.fontSize(20),
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
            ),
          ),
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductsBrowseScreen(
                  category: category,
                  title: title,
                ),
              ),
            ),
            child: Text(
              'view_all'.tr(context),
              style: GoogleFonts.cairo(
                fontSize: r.fontSize(14),
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
