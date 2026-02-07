import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/localization/app_localizations.dart';
import 'customer_detail_row.dart';

class CustomerDetailsSection extends StatelessWidget {
  final String customerName;
  final String customerPhone;
  final String customerAddress;

  const CustomerDetailsSection({
    super.key,
    required this.customerName,
    required this.customerPhone,
    required this.customerAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 12),
          CustomerDetailRow(
            icon: Icons.person_outline,
            label: 'name'.tr(context),
            value: customerName,
          ),
          const SizedBox(height: 8),
          CustomerDetailRow(
            icon: Icons.phone_outlined,
            label: 'phone'.tr(context),
            value: customerPhone,
            isPhone: true,
          ),
          const SizedBox(height: 8),
          CustomerDetailRow(
            icon: Icons.location_on_outlined,
            label: 'address'.tr(context),
            value: customerAddress,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.info_outline, size: 18, color: AppColors.primary),
        const SizedBox(width: 8),
        Text(
          'customer_details'.tr(context),
          style: AppTextStyles.bodyMedium(context).copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
