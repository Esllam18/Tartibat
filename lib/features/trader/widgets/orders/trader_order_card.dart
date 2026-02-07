import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/utils/responsive.dart';
import 'order_card_header.dart';
import 'order_card_items.dart';
import 'customer_details_section.dart';
import 'order_card_footer.dart';
import '../../view/edit_order_screen.dart';

class TraderOrderCard extends StatelessWidget {
  final int index;
  final String status;

  const TraderOrderCard({
    super.key,
    required this.index,
    required this.status,
  });

  bool get _isPaid => index % 2 == 0;

  String get _customerName => 'أحمد محمد علي';
  String get _customerPhone => '+964 770 123 4567';
  String get _customerAddress => 'بغداد، الكرادة، شارع 14، بناية 7، الطابق 3';

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Container(
      margin: EdgeInsets.only(bottom: r.spacing(16)),
      padding: EdgeInsets.all(r.spacing(16)),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 15,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OrderCardHeader(
            orderNumber: 'ORD-${1000 + index}',
            isPaid: _isPaid,
          ),
          const Divider(height: 20),
          OrderCardItems(itemCount: 2),
          if (_isPaid) ...[
            const Divider(height: 20),
            CustomerDetailsSection(
              customerName: _customerName,
              customerPhone: _customerPhone,
              customerAddress: _customerAddress,
            ),
          ],
          const Divider(height: 20),
          OrderCardFooter(
            totalAmount: 12500,
            status: status,
            onViewDetails: () => _navigateToDetails(context),
          ),
        ],
      ),
    );
  }

  void _navigateToDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const EditOrderScreen(order: {}),
      ),
    );
  }
}
