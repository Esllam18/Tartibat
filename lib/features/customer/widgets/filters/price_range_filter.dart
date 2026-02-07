import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/localization/app_localizations.dart';

class PriceRangeFilter extends StatelessWidget {
  final double? min;
  final double? max;
  final Function(double?, double?) onChanged;

  const PriceRangeFilter({
    super.key,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('price_range'.tr(context), style: AppTextStyles.h4(context)),
        const SizedBox(height: 12),
        RangeSlider(
          values: RangeValues(min ?? 0, max ?? 1000000),
          min: 0,
          max: 1000000,
          divisions: 100,
          activeColor: AppColors.primary,
          labels: RangeLabels(
            '${(min ?? 0).toInt()}',
            '${(max ?? 1000000).toInt()}',
          ),
          onChanged: (values) => onChanged(values.start, values.end),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${(min ?? 0).toInt()} ${'iqd'.tr(context)}',
              style: AppTextStyles.bodySmall(context),
            ),
            Text(
              '${(max ?? 1000000).toInt()} ${'iqd'.tr(context)}',
              style: AppTextStyles.bodySmall(context),
            ),
          ],
        ),
      ],
    );
  }
}
