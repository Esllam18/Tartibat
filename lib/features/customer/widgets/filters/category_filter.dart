import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/localization/app_localizations.dart';

class CategoryFilter extends StatelessWidget {
  final String? selected;
  final Function(String?) onChanged;

  const CategoryFilter({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final categories = ['all', 'sofa', 'table', 'chair', 'bed', 'cabinet'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('category'.tr(context), style: AppTextStyles.h4(context)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: categories.map((cat) {
            final isSelected = selected == cat;
            return ChoiceChip(
              label: Text(cat.tr(context)),
              selected: isSelected,
              onSelected: (_) => onChanged(isSelected ? null : cat),
              backgroundColor: AppColors.background,
              selectedColor: AppColors.primary,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : AppColors.textPrimary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
