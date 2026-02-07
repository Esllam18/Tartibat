import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/localization/app_localizations.dart';

class OrderStatusSelector extends StatelessWidget {
  final String current;
  final ValueChanged<String> onChanged;
  const OrderStatusSelector(
      {super.key, required this.current, required this.onChanged});

  static const _statuses = ['new', 'preparing', 'shipped', 'delivered'];
  static const _colors = {
    'new': Colors.blue,
    'preparing': Colors.orange,
    'shipped': Colors.purple,
    'delivered': Colors.green,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
          boxShadow: const [
            BoxShadow(
                color: AppColors.shadowLight,
                blurRadius: 15,
                offset: Offset(0, 4))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.sync_alt,
                    color: AppColors.primary, size: 22)),
            const SizedBox(width: 12),
            Text('update_status'.tr(context), style: AppTextStyles.h4(context))
          ]),
          const SizedBox(height: 16),
          ..._statuses.map((s) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _Pill(s, current == s, _colors[s]!, () => onChanged(s)))),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String status;
  final bool selected;
  final Color color;
  final VoidCallback onTap;
  const _Pill(this.status, this.selected, this.color, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: selected ? color.withOpacity(0.15) : AppColors.background,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
                color: selected ? color : Colors.transparent, width: 2)),
        child: Row(children: [
          Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 12),
          Expanded(
              child: Text(status.tr(context),
                  style: TextStyle(
                      fontWeight:
                          selected ? FontWeight.bold : FontWeight.normal,
                      color: selected ? color : AppColors.textPrimary))),
          if (selected) Icon(Icons.check_circle, color: color, size: 22)
        ]),
      ),
    );
  }
}
