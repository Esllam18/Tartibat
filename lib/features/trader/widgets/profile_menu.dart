import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/localization/app_localizations.dart';

class TraderProfileMenu extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  const TraderProfileMenu({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        boxShadow: const [
          BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 15,
              offset: Offset(0, 4))
        ],
      ),
      child: Column(
        children: items
            .map((item) => _MenuItem(icon: item['icon'], titleKey: item['key']))
            .toList(),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String titleKey;
  const _MenuItem({required this.icon, required this.titleKey});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.primary, size: 22),
      ),
      title:
          Text(titleKey.tr(context), style: AppTextStyles.bodyMedium(context)),
      trailing: const Icon(Icons.arrow_forward_ios,
          size: 16, color: AppColors.textSecondary),
      onTap: () {},
    );
  }
}
