import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/localization/app_localizations.dart';

class FilterBottomSheet extends StatefulWidget {
  final Function(Map<String, dynamic>) onApply;

  const FilterBottomSheet({super.key, required this.onApply});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  RangeValues _priceRange = const RangeValues(0, 10000);
  String _sortBy = 'newest';

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Container(
      padding: EdgeInsets.all(r.spacing(24)),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'filter'.tr(context),
                style: GoogleFonts.cairo(
                  fontSize: r.fontSize(20),
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          SizedBox(height: r.spacing(20)),
          Text(
            'price_range'.tr(context),
            style: GoogleFonts.cairo(
              fontSize: r.fontSize(16),
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: r.spacing(8)),
          RangeSlider(
            values: _priceRange,
            min: 0,
            max: 10000,
            divisions: 100,
            activeColor: AppColors.primary,
            labels: RangeLabels(
              '\$${_priceRange.start.round()}',
              '\$${_priceRange.end.round()}',
            ),
            onChanged: (values) => setState(() => _priceRange = values),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('\$${_priceRange.start.round()}'),
              Text('\$${_priceRange.end.round()}'),
            ],
          ),
          SizedBox(height: r.spacing(24)),
          Text(
            'sort_by'.tr(context),
            style: GoogleFonts.cairo(
              fontSize: r.fontSize(16),
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: r.spacing(12)),
          _buildSortOption('newest', 'newest'.tr(context), r),
          _buildSortOption('price_low', 'price_low_high'.tr(context), r),
          _buildSortOption('price_high', 'price_high_low'.tr(context), r),
          _buildSortOption('popular', 'most_popular'.tr(context), r),
          SizedBox(height: r.spacing(24)),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                widget.onApply({
                  'priceRange': _priceRange,
                  'sortBy': _sortBy,
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(vertical: r.spacing(16)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                'apply_filter'.tr(context),
                style: GoogleFonts.cairo(
                  fontSize: r.fontSize(16),
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSortOption(String value, String label, Responsive r) {
    return RadioListTile<String>(
      value: value,
      groupValue: _sortBy,
      title: Text(
        label,
        style: GoogleFonts.cairo(fontSize: r.fontSize(14)),
      ),
      activeColor: AppColors.primary,
      onChanged: (v) => setState(() => _sortBy = v!),
      contentPadding: EdgeInsets.zero,
    );
  }
}
