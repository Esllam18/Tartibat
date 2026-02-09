import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../data/models/order_model.dart';
import '../../view/order_details_screen.dart';

class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OrderDetailsScreen(order: order),
          ),
        );
      },
      child: Container(
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
                _buildStatusBadge(context, order.status),
              ],
            ),
            SizedBox(height: r.spacing(12)),
            Row(
              children: [
                Icon(Icons.calendar_today,
                    size: 16, color: AppColors.textSecondary),
                SizedBox(width: r.spacing(6)),
                Text(
                  _formatDate(order.createdAt, isArabic),
                  style: GoogleFonts.cairo(
                    fontSize: r.fontSize(12),
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
                    fontSize: r.fontSize(12),
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            SizedBox(height: r.spacing(12)),
            Row(
              children: [
                ...order.items.take(3).map((item) => Padding(
                      padding: EdgeInsets.only(right: r.spacing(8)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: item.imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          placeholder: (_, __) => Container(
                            color: Colors.grey.shade100,
                          ),
                          errorWidget: (_, __, ___) => Container(
                            color: Colors.grey.shade100,
                            child: Icon(Icons.image,
                                color: Colors.grey.shade400, size: 20),
                          ),
                        ),
                      ),
                    )),
                if (order.items.length > 3)
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '+${order.items.length - 3}',
                        style: GoogleFonts.cairo(
                          fontSize: r.fontSize(14),
                          fontWeight: FontWeight.w700,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                const Spacer(),
                Text(
                  '\$${order.total.toStringAsFixed(2)}',
                  style: GoogleFonts.cairo(
                    fontSize: r.fontSize(18),
                    fontWeight: FontWeight.w900,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context, String status) {
    final r = context.responsive;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    Color bgColor;
    Color textColor;
    String statusText;

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
        statusText = isArabic ? 'في الطريق' : 'On the way';
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

  String _formatDate(DateTime date, bool isArabic) {
    final months = isArabic
        ? [
            'يناير',
            'فبراير',
            'مارس',
            'أبريل',
            'مايو',
            'يونيو',
            'يوليو',
            'أغسطس',
            'سبتمبر',
            'أكتوبر',
            'نوفمبر',
            'ديسمبر'
          ]
        : [
            'Jan',
            'Feb',
            'Mar',
            'Apr',
            'May',
            'Jun',
            'Jul',
            'Aug',
            'Sep',
            'Oct',
            'Nov',
            'Dec'
          ];

    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}
