import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/localization/app_localizations.dart';

class HomeCategories extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const HomeCategories({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  static const List<Map<String, dynamic>> _categories = [
    {'id': 'all', 'key': 'all', 'icon': Icons.apps_rounded},
    {'id': 'sofas', 'key': 'categories_sofa', 'icon': Icons.weekend_rounded},
    {'id': 'chairs', 'key': 'categories_chairs', 'icon': Icons.chair_rounded},
    {
      'id': 'tables',
      'key': 'categories_tables',
      'icon': Icons.table_restaurant_rounded,
    },
    {'id': 'beds', 'key': 'categories_beds', 'icon': Icons.bed_rounded},
    {
      'id': 'storage',
      'key': 'categories_storage',
      'icon': Icons.inventory_2_rounded,
    },
    {'id': 'desks', 'key': 'categories_desks', 'icon': Icons.desk_rounded},
    {'id': 'cabinets', 'key': 'categories_cabinets', 'icon': Icons.shelves},
    {
      'id': 'lighting',
      'key': 'categories_lighting',
      'icon': Icons.lightbulb_outline,
    },
    {
      'id': 'carpets',
      'key': 'categories_carpets',
      'icon': Icons.crop_square_rounded,
    },
    {
      'id': 'curtains',
      'key': 'categories_curtains',
      'icon': Icons.window_rounded,
    },
    {
      'id': 'shelves',
      'key': 'categories_shelves',
      'icon': Icons.view_agenda_outlined,
    },
    {'id': 'outdoor', 'key': 'categories_outdoor', 'icon': Icons.yard_outlined},
    {'id': 'kids', 'key': 'categories_kids', 'icon': Icons.child_care},
    {'id': 'office', 'key': 'categories_office', 'icon': Icons.business_center},
    {
      'id': 'kitchen',
      'key': 'categories_kitchen',
      'icon': Icons.kitchen_outlined,
    },
    {
      'id': 'bathroom',
      'key': 'categories_bathroom',
      'icon': Icons.bathroom_outlined,
    },
    {
      'id': 'decor',
      'key': 'categories_decor',
      'icon': Icons.auto_awesome_outlined,
    },
    {'id': 'antique', 'key': 'categories_antique', 'icon': Icons.auto_fix_high},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const BouncingScrollPhysics(),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = selectedCategory == category['id'];

          return GestureDetector(
            onTap: () => onCategorySelected(category['id'] as String),
            child: Container(
              width: 75,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                gradient: isSelected ? AppColors.primaryGradient : null,
                color: isSelected ? null : AppColors.surface,
                borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
                boxShadow: [
                  BoxShadow(
                    color: isSelected
                        ? AppColors.primary.withOpacity(0.3)
                        : AppColors.shadowLight,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    category['icon'] as IconData,
                    size: 26,
                    color: isSelected ? Colors.white : AppColors.primary,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    (category['key'] as String).tr(context),
                    style: AppTextStyles.caption(context).copyWith(
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
