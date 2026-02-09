import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../data/models/order_model.dart';

class OrderTrackingTimeline extends StatelessWidget {
  final Order order;

  const OrderTrackingTimeline({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    final statuses = _getOrderStatuses();
    final currentStatusIndex = _getCurrentStatusIndex();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: r.spacing(16)),
      padding: EdgeInsets.all(r.spacing(20)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'order_tracking'.tr(context),
            style: GoogleFonts.cairo(
              fontSize: r.fontSize(18),
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: r.spacing(20)),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: statuses.length,
            itemBuilder: (context, index) {
              final status = statuses[index];
              final isCompleted = index <= currentStatusIndex;
              final isCurrent = index == currentStatusIndex;
              final isLast = index == statuses.length - 1;

              return _buildTimelineItem(
                context,
                r,
                isArabic,
                status,
                isCompleted,
                isCurrent,
                isLast,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(
    BuildContext context,
    Responsive r,
    bool isArabic,
    Map<String, dynamic> status,
    bool isCompleted,
    bool isCurrent,
    bool isLast,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isCompleted ? AppColors.primary : Colors.grey.shade100,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isCompleted ? AppColors.primary : Colors.grey.shade300,
                  width: 2,
                ),
              ),
              child: Icon(
                status['icon'] as IconData,
                color: isCompleted ? Colors.white : Colors.grey.shade400,
                size: 20,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 50,
                color: isCompleted ? AppColors.primary : Colors.grey.shade300,
              ),
          ],
        ),
        SizedBox(width: r.spacing(16)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                status['title'] as String,
                style: GoogleFonts.cairo(
                  fontSize: r.fontSize(15),
                  fontWeight: FontWeight.w800,
                  color: isCompleted
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
                ),
              ),
              if (isCurrent) ...[
                SizedBox(height: r.spacing(4)),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: r.spacing(8),
                    vertical: r.spacing(4),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'current_status'.tr(context),
                    style: GoogleFonts.cairo(
                      fontSize: r.fontSize(11),
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
              if (!isLast) SizedBox(height: r.spacing(16)),
            ],
          ),
        ),
      ],
    );
  }

  List<Map<String, dynamic>> _getOrderStatuses() {
    const isArabic = true; // You can pass this from context
    return [
      {
        'key': 'pending',
        // ignore: dead_code
        'title': isArabic ? 'تم استلام الطلب' : 'Order Received',
        'icon': Icons.receipt_long,
      },
      {
        'key': 'confirmed',
        // ignore: dead_code
        'title': isArabic ? 'تم تأكيد الطلب' : 'Order Confirmed',
        'icon': Icons.check_circle,
      },
      {
        'key': 'processing',
        // ignore: dead_code
        'title': isArabic ? 'جاري التحضير' : 'Processing',
        'icon': Icons.inventory_2,
      },
      {
        'key': 'shipped',
        // ignore: dead_code
        'title': isArabic ? 'تم الشحن' : 'Shipped',
        'icon': Icons.local_shipping,
      },
      {
        'key': 'outForDelivery',
        // ignore: dead_code
        'title': isArabic ? 'في الطريق إليك' : 'Out for Delivery',
        'icon': Icons.delivery_dining,
      },
      {
        'key': 'delivered',
        // ignore: dead_code
        'title': isArabic ? 'تم التوصيل' : 'Delivered',
        'icon': Icons.done_all,
      },
    ];
  }

  int _getCurrentStatusIndex() {
    switch (order.status) {
      case 'pending':
        return 0;
      case 'confirmed':
        return 1;
      case 'processing':
        return 2;
      case 'shipped':
        return 3;
      case 'outForDelivery':
        return 4;
      case 'delivered':
        return 5;
      default:
        return 0;
    }
  }
}
