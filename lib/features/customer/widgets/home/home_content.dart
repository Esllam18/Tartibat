import 'package:flutter/material.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../data/mock_data/products_data.dart';
import 'home_app_bar.dart';
import 'home_search_bar.dart';
import 'home_categories.dart';
import 'home_section_header.dart';
import 'home_products_section.dart';

class HomeContent extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategoryChanged;

  const HomeContent({
    super.key,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    final filteredProducts = selectedCategory == 'all'
        ? mockProducts.where((p) => p.isFeatured).toList()
        : mockProducts
            .where((p) => p.category == selectedCategory && p.isFeatured)
            .toList();

    return CustomScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      slivers: [
        const SliverToBoxAdapter(child: HomeAppBar()),
        SliverToBoxAdapter(
          child: HomeSearchBar(
            onFilterTap: () => _showFilters(context),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              HomeCategories(
                selectedCategory: selectedCategory,
                onCategorySelected: onCategoryChanged,
              ),
              SizedBox(height: r.spacing(20)),
              HomeSectionHeader(
                title: 'featured_products'.tr(context),
                category: selectedCategory,
              ),
              SizedBox(height: r.spacing(12)),
            ],
          ),
        ),
        HomeProductsSection(products: filteredProducts),
        SliverToBoxAdapter(
          child: SizedBox(height: r.spacing(80)),
        ),
      ],
    );
  }

  void _showFilters(BuildContext context) {
    // TODO: Implement filter bottom sheet
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('filter_coming_soon'.tr(context)),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
