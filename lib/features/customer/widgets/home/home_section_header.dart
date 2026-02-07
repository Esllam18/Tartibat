import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/search/product_search_delegate.dart';
import '../../../../core/models/product_filter.dart';
import '../filters/filter_bottom_sheet.dart';

class HomeSearchBar extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final ProductFilter currentFilter;
  final Function(ProductFilter) onFilterChanged;

  const HomeSearchBar({
    super.key,
    required this.products,
    required this.currentFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => _showSearch(context),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: AppColors.textSecondary),
                    const SizedBox(width: 12),
                    Text(
                      'search_products'.tr(context),
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
            icon: Icon(
              Icons.filter_list,
              color: currentFilter.hasFilters
                  ? AppColors.primary
                  : AppColors.textSecondary,
            ),
            onPressed: () => _showFilters(context),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.background,
            ),
          ),
        ],
      ),
    );
  }

  void _showSearch(BuildContext context) {
    showSearch(
      context: context,
      delegate: ProductSearchDelegate(products),
    );
  }

  void _showFilters(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => FilterBottomSheet(
        currentFilter: currentFilter,
        onApply: onFilterChanged,
      ),
    );
  }
}
