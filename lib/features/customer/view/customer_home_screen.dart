import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../widgets/home/home_app_bar.dart';
import '../widgets/home/home_search_bar.dart';
import '../widgets/home/home_categories.dart';
import '../widgets/home/home_products_grid.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  String _selectedCategory = 'all';
  bool _isGridView = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          HomeAppBar(
            isGridView: _isGridView,
            onLayoutToggle: () => setState(() => _isGridView = !_isGridView),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const HomeSearchBar(),
                HomeCategories(
                  selectedCategory: _selectedCategory,
                  onCategorySelected: (cat) =>
                      setState(() => _selectedCategory = cat),
                ),
                HomeProductsGrid(category: _selectedCategory),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
