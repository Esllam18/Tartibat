import 'package:flutter/material.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/localization/app_localizations.dart';
import 'recent_order_item.dart';

class RecentOrdersSection extends StatelessWidget {
  final List<Map<String, dynamic>> orders;

  const RecentOrdersSection({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'recent_orders'.tr(context),
              style: AppTextStyles.h4(context),
            ),
            TextButton(
              onPressed: () {},
              child: Text('view_all'.tr(context)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...orders.take(5).map((order) => RecentOrderItem(order: order)),
      ],
    );
  }
}
