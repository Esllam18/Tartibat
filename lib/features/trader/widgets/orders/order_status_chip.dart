import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/app_localizations.dart';

class OrderStatusChip extends StatelessWidget {
  final String status;

  const OrderStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final config = _getStatusConfig(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: config.color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        config.label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  _StatusConfig _getStatusConfig(BuildContext context) {
    switch (status.toLowerCase()) {
      case 'new':
        return _StatusConfig(color: AppColors.info, label: 'new'.tr(context));
      case 'preparing':
        return _StatusConfig(
          color: AppColors.warning,
          label: 'preparing'.tr(context),
        );
      case 'shipped':
        return _StatusConfig(
          color: AppColors.primary,
          label: 'shipped'.tr(context),
        );
      case 'delivered':
        return _StatusConfig(
          color: AppColors.success,
          label: 'delivered'.tr(context),
        );
      default:
        return _StatusConfig(color: AppColors.textSecondary, label: status);
    }
  }
}

class _StatusConfig {
  final Color color;
  final String label;
  _StatusConfig({required this.color, required this.label});
}
