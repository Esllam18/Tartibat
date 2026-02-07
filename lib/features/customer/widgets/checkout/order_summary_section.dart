import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/localization/app_localizations.dart';

class OrderSummarySection extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final int subtotal;
  final int deliveryFee;
  final int total;

  const OrderSummarySection({
    super.key,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Container(
      padding: EdgeInsets.all(r.spacing(AppDimensions.paddingMedium)),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        boxShadow: const [
          BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 15,
              offset: Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(r.spacing(8)),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusMedium),
                ),
                child: Icon(
                  Icons.receipt_long,
                  color: AppColors.primary,
                  size: r.responsive(mobile: 22, tablet: 24, desktop: 26),
                ),
              ),
              SizedBox(width: r.spacing(12)),
              Text('order_summary'.tr(context),
                  style: AppTextStyles.h4(context)),
            ],
          ),
          SizedBox(height: r.spacing(16)),
          ...items.map((item) => _buildOrderItem(context, item, r)),
          Divider(height: r.spacing(24), thickness: 1),
          _buildPriceLine(context, 'subtotal'.tr(context), subtotal, false, r),
          SizedBox(height: r.spacing(12)),
          _buildPriceLine(
              context, 'delivery_fee'.tr(context), deliveryFee, false, r),
          Divider(height: r.spacing(24), thickness: 1),
          _buildPriceLine(context, 'grand_total'.tr(context), total, true, r),
        ],
      ),
    );
  }

  Widget _buildOrderItem(
      BuildContext context, Map<String, dynamic> item, Responsive r) {
    return Padding(
      padding: EdgeInsets.only(bottom: r.spacing(12)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
            child: Image.network(
              item['image'] as String,
              width: r.responsive(mobile: 50, tablet: 60, desktop: 70),
              height: r.responsive(mobile: 50, tablet: 60, desktop: 70),
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: r.responsive(mobile: 50, tablet: 60, desktop: 70),
                height: r.responsive(mobile: 50, tablet: 60, desktop: 70),
                color: AppColors.background,
                child: const Icon(Icons.image_not_supported,
                    size: 24, color: AppColors.primaryLight),
              ),
            ),
          ),
          SizedBox(width: r.spacing(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'] as String,
                  style: AppTextStyles.bodySmall(context)
                      .copyWith(fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: r.spacing(4)),
                Text(
                  '${'quantity'.tr(context)}: ${item['quantity']}',
                  style: AppTextStyles.caption(context),
                ),
              ],
            ),
          ),
          Text(
            '${(item['price'] as int) * (item['quantity'] as int)} ${'egp'.tr(context)}',
            style: AppTextStyles.bodyMedium(context).copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceLine(BuildContext context, String label, int amount,
      bool isTotal, Responsive r) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal
              ? AppTextStyles.h4(context)
              : AppTextStyles.bodyMedium(context),
        ),
        Text(
          '$amount ${'egp'.tr(context)}',
          style: isTotal
              ? AppTextStyles.price(context).copyWith(fontSize: r.fontSize(20))
              : AppTextStyles.bodyMedium(context)
                  .copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
