import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../customer/data/models/order_model.dart';
import '../../bloc/merchant_orders_cubit.dart';

class OrderStatusUpdateSheet extends StatelessWidget {
  final Order order;

  const OrderStatusUpdateSheet({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    final statuses = [
      {
        'key': 'confirmed',
        'label': isArabic ? 'تأكيد الطلب' : 'Confirm Order',
        'icon': Icons.check_circle
      },
      {
        'key': 'processing',
        'label': isArabic ? 'جاري التحضير' : 'Processing',
        'icon': Icons.inventory_2
      },
      {
        'key': 'shipped',
        'label': isArabic ? 'تم الشحن' : 'Shipped',
        'icon': Icons.local_shipping
      },
      {
        'key': 'outForDelivery',
        'label': isArabic ? 'في الطريق' : 'Out for Delivery',
        'icon': Icons.delivery_dining
      },
      {
        'key': 'delivered',
        'label': isArabic ? 'تم التوصيل' : 'Delivered',
        'icon': Icons.done_all
      },
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.all(r.spacing(24)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(height: r.spacing(20)),
          Text(
            'update_order_status'.tr(context),
            style: GoogleFonts.cairo(
              fontSize: r.fontSize(20),
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: r.spacing(24)),
          ...statuses.map((status) {
            return Padding(
              padding: EdgeInsets.only(bottom: r.spacing(12)),
              child: ListTile(
                onTap: () {
                  context.read<MerchantOrdersCubit>().updateOrderStatus(
                        order.id,
                        status['key'] as String,
                      );
                  Navigator.pop(context);
                },
                leading: Container(
                  padding: EdgeInsets.all(r.spacing(10)),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    status['icon'] as IconData,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                title: Text(
                  status['label'] as String,
                  style: GoogleFonts.cairo(
                    fontSize: r.fontSize(15),
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.grey.shade200),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
