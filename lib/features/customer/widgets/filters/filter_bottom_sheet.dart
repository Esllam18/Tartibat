import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/models/product_filter.dart';
import 'category_filter.dart';
import 'price_range_filter.dart';
import '../sort_filter.dart';

class FilterBottomSheet extends StatefulWidget {
  final ProductFilter currentFilter;
  final Function(ProductFilter) onApply;

  const FilterBottomSheet({
    super.key,
    required this.currentFilter,
    required this.onApply,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late ProductFilter _filter;

  @override
  void initState() {
    super.initState();
    _filter = widget.currentFilter;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(context),
          const SizedBox(height: 20),
          CategoryFilter(
            selected: _filter.category,
            onChanged: (cat) =>
                setState(() => _filter = _filter.copyWith(category: cat)),
          ),
          const SizedBox(height: 16),
          PriceRangeFilter(
            min: _filter.minPrice,
            max: _filter.maxPrice,
            onChanged: (min, max) => setState(() {
              _filter = _filter.copyWith(minPrice: min, maxPrice: max);
            }),
          ),
          const SizedBox(height: 16),
          SortFilter(
            selected: _filter.sortBy,
            onChanged: (sort) =>
                setState(() => _filter = _filter.copyWith(sortBy: sort)),
          ),
          const SizedBox(height: 20),
          _buildButtons(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('filters'.tr(context), style: AppTextStyles.h3(context)),
        TextButton(
          onPressed: () => setState(() => _filter = ProductFilter()),
          child: Text('clear_all'.tr(context)),
        ),
      ],
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: Text('cancel'.tr(context)),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              widget.onApply(_filter);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: Text('apply'.tr(context)),
          ),
        ),
      ],
    );
  }
}
