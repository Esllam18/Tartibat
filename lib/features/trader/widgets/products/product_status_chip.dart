import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/app_localizations.dart';

class ProductStatusChip extends StatelessWidget {
  final String status;

  const ProductStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final config = _getStatusConfig(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: config.color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: config.color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(config.icon, size: 14, color: Colors.white),
          const SizedBox(width: 4),
          Text(
            config.label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  _StatusConfig _getStatusConfig(BuildContext context) {
    switch (status.toLowerCase()) {
      case 'approved':
        return _StatusConfig(
          color: AppColors.statusApproved,
          icon: Icons.check_circle,
          label: 'approved'.tr(context),
        );
      case 'rejected':
        return _StatusConfig(
          color: AppColors.statusRejected,
          icon: Icons.cancel,
          label: 'rejected'.tr(context),
        );
      default:
        return _StatusConfig(
          color: AppColors.statusPending,
          icon: Icons.schedule,
          label: 'pending'.tr(context),
        );
    }
  }
}

class _StatusConfig {
  final Color color;
  final IconData icon;
  final String label;

  _StatusConfig({
    required this.color,
    required this.icon,
    required this.label,
  });
}
