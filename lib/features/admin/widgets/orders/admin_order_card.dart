import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/localization/app_localizations.dart';

class AdminOrderCard extends StatelessWidget {
  final Map<String, dynamic> order;

  const AdminOrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${'order'.tr(context)} #${order['id'] ?? 'N/A'}',
                style: AppTextStyles.h4(context),
              ),
              _buildStatusChip(order['status'] ?? 'pending'),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.person,
                  size: 16, color: AppColors.textSecondary),
              const SizedBox(width: 4),
              Text(
                order['customer'] ?? 'Unknown',
                style: AppTextStyles.bodySmall(context),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.store, size: 16, color: AppColors.textSecondary),
              const SizedBox(width: 4),
              Text(
                order['trader'] ?? 'Unknown',
                style: AppTextStyles.bodySmall(context),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                order['date'] ?? '',
                style: AppTextStyles.bodySmall(context),
              ),
              Text(
                '${order['total'] ?? 0} IQD',
                style: AppTextStyles.h4(context)
                    .copyWith(color: AppColors.primary),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status) {
      case 'delivered':
        color = AppColors.success;
        break;
      case 'shipped':
        color = AppColors.info;
        break;
      case 'cancelled':
        color = AppColors.error;
        break;
      default:
        color = AppColors.warning;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style:
            TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }
}
