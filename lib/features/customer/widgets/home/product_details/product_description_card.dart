import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/responsive.dart';
import '../../../../../core/localization/app_localizations.dart';

class ProductDescriptionCard extends StatelessWidget {
  const ProductDescriptionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Container(
      padding: EdgeInsets.all(r.spacing(20)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(r.spacing(10)),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.description_outlined,
                  color: AppColors.primary,
                  size: r.responsive(mobile: 22, tablet: 24, desktop: 26),
                ),
              ),
              SizedBox(width: r.spacing(12)),
              Text(
                'description'.tr(context),
                style: GoogleFonts.cairo(
                  fontSize: r.fontSize(18),
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: r.spacing(16)),
          Text(
            isArabic
                ? 'هذا المنتج مصنوع من مواد عالية الجودة ويتميز بتصميم عصري وأنيق يناسب جميع الأذواق. يوفر راحة استثنائية ومتانة طويلة الأمد.'
                : 'This product is made from high-quality materials and features a modern, elegant design that suits all tastes. It provides exceptional comfort and long-lasting durability.',
            style: GoogleFonts.cairo(
              fontSize: r.fontSize(15),
              color: AppColors.textSecondary,
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }
}
