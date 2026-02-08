import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/responsive.dart';
import '../../../../../core/localization/app_localizations.dart';

class ProductSpecificationsCard extends StatelessWidget {
  const ProductSpecificationsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    final specs = [
      {
        'key': 'material'.tr(context),
        'value': isArabic ? 'خشب طبيعي' : 'Natural Wood'
      },
      {'key': 'dimensions'.tr(context), 'value': '200 × 150 cm'},
      {'key': 'weight'.tr(context), 'value': '45 kg'},
      {'key': 'warranty'.tr(context), 'value': isArabic ? 'سنتان' : '2 Years'},
    ];

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
                  Icons.info_outline,
                  color: AppColors.primary,
                  size: r.responsive(mobile: 22, tablet: 24, desktop: 26),
                ),
              ),
              SizedBox(width: r.spacing(12)),
              Text(
                'specifications'.tr(context),
                style: GoogleFonts.cairo(
                  fontSize: r.fontSize(18),
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: r.spacing(16)),
          ...specs.map((spec) =>
              _buildSpecRow(context, r, spec['key']!, spec['value']!)),
        ],
      ),
    );
  }

  Widget _buildSpecRow(
      BuildContext context, Responsive r, String key, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: r.spacing(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            key,
            style: GoogleFonts.cairo(
              fontSize: r.fontSize(15),
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.cairo(
              fontSize: r.fontSize(15),
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
