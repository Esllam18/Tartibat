import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tartibat/features/merchant/bloc/merchant_orders_cubit.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../customer/data/models/order_model.dart';
import 'order_status_update_sheet.dart';

class MerchantOrderCard extends StatelessWidget {
  final Order order;

  const MerchantOrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Container(
      margin: EdgeInsets.only(bottom: r.spacing(12)),
      padding: EdgeInsets.all(r.spacing(16)),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${'order'.tr(context)} #${order.id.substring(order.id.length - 6)}',
                style: GoogleFonts.cairo(
                  fontSize: r.fontSize(16),
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                ),
              ),
              _buildStatusBadge(context, r, order.status),
            ],
          ),
          SizedBox(height: r.spacing(12)),
          Row(
            children: [
              Icon(Icons.person, size: 16, color: AppColors.textSecondary),
              SizedBox(width: r.spacing(6)),
              Text(
                order.address.name,
                style: GoogleFonts.cairo(
                  fontSize: r.fontSize(13),
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(width: r.spacing(16)),
              Icon(Icons.shopping_bag,
                  size: 16, color: AppColors.textSecondary),
              SizedBox(width: r.spacing(6)),
              Text(
                '${order.items.length} ${'items'.tr(context)}',
                style: GoogleFonts.cairo(
                  fontSize: r.fontSize(13),
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: r.spacing(12)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${order.total.toStringAsFixed(2)}',
                style: GoogleFonts.cairo(
                  fontSize: r.fontSize(20),
                  fontWeight: FontWeight.w900,
                  color: AppColors.primary,
                ),
              ),
              if (order.status != 'delivered' && order.status != 'cancelled')
                ElevatedButton.icon(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (_) => BlocProvider.value(
                        value: context.read<MerchantOrdersCubit>(),
                        child: OrderStatusUpdateSheet(order: order),
                      ),
                    );
                  },
                  icon: const Icon(Icons.update, size: 18),
                  label: Text(
                    'update_status'.tr(context),
                    style: GoogleFonts.cairo(
                      fontSize: r.fontSize(12),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(
                      horizontal: r.spacing(12),
                      vertical: r.spacing(8),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context, Responsive r, String status) {
    Color bgColor;
    Color textColor;
    String statusText;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    switch (status) {
      case 'delivered':
        bgColor = AppColors.success.withOpacity(0.1);
        textColor = AppColors.success;
        statusText = isArabic ? 'تم التوصيل' : 'Delivered';
        break;
      case 'shipped':
      case 'outForDelivery':
        bgColor = Colors.blue.withOpacity(0.1);
        textColor = Colors.blue;
        statusText = isArabic ? 'في الطريق' : 'Shipping';
        break;
      case 'cancelled':
        bgColor = AppColors.error.withOpacity(0.1);
        textColor = AppColors.error;
        statusText = isArabic ? 'ملغي' : 'Cancelled';
        break;
      default:
        bgColor = Colors.orange.withOpacity(0.1);
        textColor = Colors.orange;
        statusText = isArabic ? 'قيد المعالجة' : 'Processing';
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: r.spacing(10),
        vertical: r.spacing(6),
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        statusText,
        style: GoogleFonts.cairo(
          fontSize: r.fontSize(12),
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
      ),
    );
  }
}
