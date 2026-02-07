import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/loading_state.dart';
import '../widgets/products/products_empty.dart';
import '../widgets/trader_products_grid.dart';
import '../widgets/trader_products_list.dart';
import '../widgets/trader_search_bar.dart';
import 'add_product_screen.dart';

class TraderProductsScreen extends StatefulWidget {
  const TraderProductsScreen({super.key});

  @override
  State<TraderProductsScreen> createState() => _TraderProductsScreenState();
}

class _TraderProductsScreenState extends State<TraderProductsScreen> {
  bool _isGridView = true;
  bool _isLoading = false;

  // Mock data - replace with real data from backend
  final List<Map<String, dynamic>> _products = [
    {
      'id': 1,
      'name': 'Luxury Sofa',
      'price': 450000,
      'image':
          'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400',
    },
    {
      'id': 2,
      'name': 'Dining Table',
      'price': 320000,
      'image':
          'https://images.unsplash.com/photo-1617806118233-18e1de247200?w=400',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          TraderSearchBar(
            onViewToggle: () => setState(() => _isGridView = !_isGridView),
          ),
          Expanded(
            child: _isLoading
                ? const LoadingState()
                : _products.isEmpty
                    ? ProductsEmpty(onAddProduct: _navigateToAddProduct)
                    : _isGridView
                        ? TraderProductsGrid(products: _products)
                        : TraderProductsList(products: _products),
          ),
        ],
      ),
    );
  }

  void _navigateToAddProduct() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddProductScreen()),
    );
  }
}
