import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/localization/app_localizations.dart';

class TraderSearchBar extends StatelessWidget {
  final VoidCallback? onViewToggle;

  const TraderSearchBar({super.key, this.onViewToggle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppColors.surface,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'search_products'.tr(context),
                  border: InputBorder.none,
                  icon:
                      const Icon(Icons.search, color: AppColors.textSecondary),
                ),
              ),
            ),
          ),
          if (onViewToggle != null) ...[
            const SizedBox(width: 12),
            IconButton(
              icon: const Icon(Icons.view_module),
              onPressed: onViewToggle,
              style: IconButton.styleFrom(
                backgroundColor: AppColors.primary.withOpacity(0.1),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
