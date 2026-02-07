import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../view/edit_order_screen.dart';

class TraderOrderCard extends StatelessWidget {
  final int index;
  final String status;
  const TraderOrderCard({super.key, required this.index, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
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
        children: [
          Row(children: [
            Expanded(
                child: Text('${'order'.tr(context)} #${1000 + index}',
                    style: AppTextStyles.bodyMedium(context)
                        .copyWith(fontWeight: FontWeight.bold))),
            IconButton(
                icon: const Icon(Icons.edit_outlined,
                    color: AppColors.primary, size: 20),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => EditOrderScreen(order: {
                              'id': 1000 + index,
                              'status': status,
                              'total': 9000000
                            })))),
            _Chip(status)
          ]),
          const SizedBox(height: 10),
          Row(children: [
            const Icon(Icons.chair_outlined,
                color: AppColors.textSecondary, size: 18),
            const SizedBox(width: 8),
            Expanded(
                child: Text('كنبة مودرن × 2',
                    style: AppTextStyles.bodySmall(context)
                        .copyWith(color: AppColors.textSecondary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis))
          ]),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(
                child: Text('9,000,000 ${'iqd'.tr(context)}',
                    style: AppTextStyles.price(context), maxLines: 1)),
            if (status != 'delivered') const SizedBox(width: 10),
            if (status != 'delivered')
              Expanded(
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      child: Text(_next(status).tr(context),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold))))
          ]),
        ],
      ),
    );
  }

  String _next(String s) => s == 'new'
      ? 'start_preparing'
      : s == 'preparing'
          ? 'mark_shipped'
          : 'mark_delivered';
}

class _Chip extends StatelessWidget {
  final String status;
  const _Chip(this.status);

  @override
  Widget build(BuildContext context) {
    final color = status == 'new'
        ? Colors.blue
        : status == 'preparing'
            ? Colors.orange
            : status == 'shipped'
                ? Colors.purple
                : Colors.green;
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(999)),
        child: Text(status.tr(context),
            style: TextStyle(
                color: color, fontWeight: FontWeight.bold, fontSize: 12)));
  }
}
