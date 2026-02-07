import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/localization/app_localizations.dart';

class AdminPendingApprovals extends StatelessWidget {
  final int pendingTraders;
  final int pendingProducts;

  const AdminPendingApprovals({
    super.key,
    required this.pendingTraders,
    required this.pendingProducts,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.warning.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.warning),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.pending_actions, color: AppColors.warning),
              const SizedBox(width: 8),
              Text(
                'pending_approvals'.tr(context),
                style: AppTextStyles.h4(context),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildPendingItem(
              context, 'pending_traders'.tr(context), pendingTraders),
          const SizedBox(height: 8),
          _buildPendingItem(
              context, 'pending_products'.tr(context), pendingProducts),
        ],
      ),
    );
  }

  Widget _buildPendingItem(BuildContext context, String label, int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.bodyMedium(context)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.warning,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '$count',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
