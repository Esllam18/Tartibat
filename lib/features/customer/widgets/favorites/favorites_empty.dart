import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/localization/app_localizations.dart';

class FavoritesEmpty extends StatelessWidget {
  const FavoritesEmpty({super.key});

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
              Icons.favorite_border,
              size: r.responsive(mobile: 80, tablet: 100, desktop: 120),
              color: AppColors.primary.withOpacity(0.5),
            ),
          ),
          SizedBox(height: r.spacing(24)),
          Text('empty_favorites'.tr(context), style: AppTextStyles.h3(context)),
          SizedBox(height: r.spacing(8)),
          Text(
            'empty_favorites_message'.tr(context),
            style: AppTextStyles.bodyMedium(context),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
