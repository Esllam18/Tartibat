import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/localization/app_localizations.dart';
import '../data/mock_data/products_data.dart';
import '../widgets/home/home_app_bar.dart';
import '../widgets/home/home_search_bar.dart';
import '../widgets/home/home_categories.dart';
import '../widgets/home/home_section_header.dart';
import '../widgets/home/product_card_grid.dart';
import '../widgets/home/filter_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'all';
  Map<String, dynamic>? _filters;

  void _onCategoryChanged(String category) {
    setState(() => _selectedCategory = category);
  }

  void _showFilters() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => FilterBottomSheet(
        onApply: (filters) {
          setState(() => _filters = filters);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('filter_applied'.tr(context)),
              duration: const Duration(seconds: 1),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final filteredProducts = _getFilteredProducts();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const HomeAppBar(),
          HomeSearchBar(onFilterTap: _showFilters),
          SizedBox(height: r.spacing(8)),
          HomeCategories(
            selectedCategory: _selectedCategory,
            onCategorySelected: _onCategoryChanged,
          ),
          SizedBox(height: r.spacing(20)),
          HomeSectionHeader(
            title: 'featured_products'.tr(context),
            category: _selectedCategory,
          ),
          SizedBox(height: r.spacing(12)),
          _buildProductsGrid(filteredProducts, r),
          SizedBox(height: r.spacing(80)),
        ],
      ),
    );
  }

  Widget _buildProductsGrid(List products, Responsive r) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: r.spacing(16)),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: r.spacing(12),
          mainAxisSpacing: r.spacing(12),
          childAspectRatio: 0.68,
        ),
        itemCount: products.length > 6 ? 6 : products.length,
        itemBuilder: (context, index) {
          return ProductCardGrid(product: products[index]);
        },
      ),
    );
  }

  List _getFilteredProducts() {
    var products = _selectedCategory == 'all'
        ? mockProducts.where((p) => p.isFeatured).toList()
        : mockProducts
            .where((p) => p.category == _selectedCategory && p.isFeatured)
            .toList();

    if (_filters != null) {
      final priceRange = _filters!['priceRange'] as RangeValues;
      products = products
          .where(
              (p) => p.price >= priceRange.start && p.price <= priceRange.end)
          .toList();

      final sortBy = _filters!['sortBy'] as String;
      if (sortBy == 'price_low') {
        products.sort((a, b) => a.price.compareTo(b.price));
      } else if (sortBy == 'price_high') {
        products.sort((a, b) => b.price.compareTo(a.price));
      }
    }

    return products;
  }
}
