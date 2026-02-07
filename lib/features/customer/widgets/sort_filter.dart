import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/localization/app_localizations.dart';

class SortFilter extends StatelessWidget {
  final String? selected;
  final Function(String?) onChanged;

  const SortFilter({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final sortOptions = [
      {'value': 'price_low', 'label': 'price_low_high'.tr(context)},
      {'value': 'price_high', 'label': 'price_high_low'.tr(context)},
      {'value': 'name', 'label': 'name_az'.tr(context)},
      {'value': 'newest', 'label': 'newest_first'.tr(context)},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('sort_by'.tr(context), style: AppTextStyles.h4(context)),
        const SizedBox(height: 12),
        ...sortOptions.map((option) {
          // ignore: unused_local_variable
          final isSelected = selected == option['value'];
          return RadioListTile<String>(
            title: Text(option['label']!),
            value: option['value']!,
            groupValue: selected,
            onChanged: onChanged,
            activeColor: AppColors.primary,
            contentPadding: EdgeInsets.zero,
            dense: true,
          );
        }),
      ],
    );
  }
}
