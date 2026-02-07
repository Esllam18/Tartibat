import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/localization/app_localizations.dart';

class SalesChart extends StatelessWidget {
  const SalesChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'sales_overview'.tr(context),
            style: AppTextStyles.h4(context),
          ),
          const SizedBox(height: 20),
          _buildChartPlaceholder(),
        ],
      ),
    );
  }

  Widget _buildChartPlaceholder() {
    return SizedBox(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(7, (index) {
          final heights = [120.0, 150.0, 100.0, 180.0, 140.0, 160.0, 130.0];
          return _buildBar(heights[index]);
        }),
      ),
    );
  }

  Widget _buildBar(double height) {
    return Container(
      width: 30,
      height: height,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
