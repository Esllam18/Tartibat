import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/localization/app_localizations.dart';

class OrdersTabs extends StatelessWidget {
  final String selectedTab;
  final Function(String) onTabChanged;
  final Map<String, int> orderCounts;

  const OrdersTabs({
    super.key,
    required this.selectedTab,
    required this.onTabChanged,
    required this.orderCounts,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
          horizontal: r.spacing(16), vertical: r.spacing(12)),
      child: Row(
        children: [
          _buildTab(context, 'all', 'all_orders'.tr(context),
              orderCounts['all'] ?? 0),
          SizedBox(width: r.spacing(12)),
          _buildTab(context, 'active', 'active'.tr(context),
              orderCounts['active'] ?? 0),
          SizedBox(width: r.spacing(12)),
          _buildTab(context, 'delivered', 'delivered'.tr(context),
              orderCounts['delivered'] ?? 0),
        ],
      ),
    );
  }

  Widget _buildTab(BuildContext context, String tab, String label, int count) {
    final r = context.responsive;
    final isSelected = selectedTab == tab;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTabChanged(tab),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: r.spacing(10)),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                label,
                style: GoogleFonts.cairo(
                  fontSize: r.fontSize(13),
                  fontWeight: FontWeight.w700,
                  color: isSelected ? Colors.white : AppColors.textSecondary,
                ),
              ),
              SizedBox(height: r.spacing(4)),
              Text(
                '$count',
                style: GoogleFonts.cairo(
                  fontSize: r.fontSize(16),
                  fontWeight: FontWeight.w900,
                  color: isSelected ? Colors.white : AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
