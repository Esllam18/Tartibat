import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../data/models/order_model.dart';

class OrderInfoSection extends StatelessWidget {
  final Order order;

  const OrderInfoSection({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: r.spacing(16)),
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
          Text(
            'order_information'.tr(context),
            style: GoogleFonts.cairo(
              fontSize: r.fontSize(16),
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: r.spacing(16)),
          _buildInfoRow(context, r, Icons.tag, 'order_id'.tr(context),
              '#${order.id.substring(order.id.length - 8)}'),
          SizedBox(height: r.spacing(12)),
          _buildInfoRow(context, r, Icons.calendar_today,
              'order_date'.tr(context), _formatDate(order.createdAt)),
          SizedBox(height: r.spacing(12)),
          _buildInfoRow(context, r, Icons.payment, 'payment_method'.tr(context),
              'credit_card'.tr(context)),
          Divider(height: r.spacing(24)),
          _buildAddressInfo(context, r),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, Responsive r, IconData icon,
      String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.textSecondary),
        SizedBox(width: r.spacing(12)),
        Text(
          label,
          style: GoogleFonts.cairo(
            fontSize: r.fontSize(13),
            color: AppColors.textSecondary,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: GoogleFonts.cairo(
            fontSize: r.fontSize(13),
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildAddressInfo(BuildContext context, Responsive r) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.location_on, size: 18, color: AppColors.textSecondary),
            SizedBox(width: r.spacing(12)),
            Text(
              'delivery_address'.tr(context),
              style: GoogleFonts.cairo(
                fontSize: r.fontSize(13),
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        SizedBox(height: r.spacing(8)),
        Padding(
          padding: EdgeInsets.only(left: r.spacing(30)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                order.address.name,
                style: GoogleFonts.cairo(
                  fontSize: r.fontSize(14),
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: r.spacing(4)),
              Text(
                order.address.phone,
                style: GoogleFonts.cairo(
                  fontSize: r.fontSize(13),
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: r.spacing(4)),
              Text(
                order.address.fullAddress,
                style: GoogleFonts.cairo(
                  fontSize: r.fontSize(13),
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} - ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
