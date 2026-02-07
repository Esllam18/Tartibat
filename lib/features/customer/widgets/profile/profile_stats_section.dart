import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/localization/app_localizations.dart';

class ProfileStatsSection extends StatelessWidget {
  const ProfileStatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: r.paddingHorizontal),
      child: Row(
        children: [
          Expanded(
              child: _buildStatCard(context, r, Icons.shopping_bag_outlined,
                  '12', 'orders_count'.tr(context))),
          SizedBox(width: r.spacing(12)),
          Expanded(
              child: _buildStatCard(context, r, Icons.favorite_outline, '8',
                  'favorites_count'.tr(context))),
          SizedBox(width: r.spacing(12)),
          Expanded(
              child: _buildStatCard(context, r, Icons.location_on_outlined, '3',
                  'addresses_count'.tr(context))),
        ],
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, Responsive r, IconData icon,
      String count, String label) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: r.spacing(20),
        horizontal: r.spacing(12),
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 15,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(r.spacing(10)),
            decoration: const BoxDecoration(
              gradient: AppColors.primaryGradient,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: r.responsive(mobile: 22, tablet: 24, desktop: 26),
            ),
          ),
          SizedBox(height: r.spacing(10)),
          Text(
            count,
            style: AppTextStyles.h3(context).copyWith(
              fontSize: r.fontSize(22),
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: r.spacing(4)),
          Text(
            label,
            style: AppTextStyles.caption(context),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
