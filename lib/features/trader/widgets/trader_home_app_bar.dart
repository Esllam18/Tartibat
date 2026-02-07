import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/localization/app_localizations.dart';

class TraderHomeAppBar extends StatelessWidget {
  final bool isGridView;
  final VoidCallback onLayoutToggle;

  const TraderHomeAppBar({
    super.key,
    required this.isGridView,
    required this.onLayoutToggle,
  });

  String _getGreeting(BuildContext context) {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'good_morning'.tr(context);
    if (hour < 17) return 'good_afternoon'.tr(context);
    return 'good_evening'.tr(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 24),
      decoration: const BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppDimensions.radiusXLarge),
          bottomRight: Radius.circular(AppDimensions.radiusXLarge),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getGreeting(context),
                  style: AppTextStyles.bodyMediumStatic.copyWith(
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'trader_portal'.tr(context),
                  style: AppTextStyles.h1Static.copyWith(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
                Text(
                  'manage_your_products'.tr(context),
                  style: AppTextStyles.bodySmall(context).copyWith(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  isGridView
                      ? Icons.view_list_rounded
                      : Icons.grid_view_rounded,
                  color: Colors.white,
                ),
                onPressed: onLayoutToggle,
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusMedium),
                ),
                child: const Icon(
                  Icons.inventory_2_outlined,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
