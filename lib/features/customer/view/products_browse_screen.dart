import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/localization/app_localizations.dart';
import '../data/mock_data/products_data.dart';
import '../data/models/product_model.dart';
import '../widgets/home/product_card_grid.dart';
import '../widgets/home/product_card_list.dart';
import '../widgets/home/filter_bottom_sheet.dart';

class ProductsBrowseScreen extends StatefulWidget {
  final String category;
  final String? title;

  const ProductsBrowseScreen({
    super.key,
    required this.category,
    this.title,
  });

  @override
  State<ProductsBrowseScreen> createState() => _ProductsBrowseScreenState();
}

class _ProductsBrowseScreenState extends State<ProductsBrowseScreen> {
  bool _isGridView = true;
  List<Product> _products = [];
  Map<String, dynamic>? _filters;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() {
    setState(() {
      _products = widget.category == 'all'
          ? mockProducts
          : mockProducts.where((p) => p.category == widget.category).toList();
      _applyFilters();
    });
  }

  void _applyFilters() {
    if (_filters == null) return;

    final priceRange = _filters!['priceRange'] as RangeValues;
    setState(() {
      _products = _products
          .where(
              (p) => p.price >= priceRange.start && p.price <= priceRange.end)
          .toList();

      final sortBy = _filters!['sortBy'] as String;
      if (sortBy == 'price_low') {
        _products.sort((a, b) => a.price.compareTo(b.price));
      } else if (sortBy == 'price_high') {
        _products.sort((a, b) => b.price.compareTo(a.price));
      }
    });
  }

  void _showFilters() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => FilterBottomSheet(
        onApply: (filters) {
          _filters = filters;
          _loadProducts();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.title ?? 'all_products'.tr(context),
          style: GoogleFonts.cairo(
            fontSize: r.fontSize(18),
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isGridView ? Icons.view_list_rounded : Icons.grid_view_rounded,
              color: AppColors.textPrimary,
            ),
            onPressed: () => setState(() => _isGridView = !_isGridView),
          ),
          IconButton(
            icon: const Icon(Icons.tune_rounded, color: AppColors.textPrimary),
            onPressed: _showFilters,
          ),
        ],
      ),
      body: _products.isEmpty ? _buildEmptyState(r) : _buildList(r),
    );
  }

  Widget _buildList(Responsive r) {
    if (_isGridView) {
      return GridView.builder(
        padding: EdgeInsets.all(r.spacing(16)),
        physics: const BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: r.responsive(mobile: 2, tablet: 3, desktop: 4),
          crossAxisSpacing: r.spacing(12),
          mainAxisSpacing: r.spacing(12),
          childAspectRatio: 0.68,
        ),
        itemCount: _products.length,
        itemBuilder: (context, index) =>
            ProductCardGrid(product: _products[index]),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(r.spacing(16)),
      physics: const BouncingScrollPhysics(),
      itemCount: _products.length,
      itemBuilder: (context, index) =>
          ProductCardList(product: _products[index]),
    );
  }

  Widget _buildEmptyState(Responsive r) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inventory_2_outlined,
              size: 80, color: Colors.grey.shade300),
          SizedBox(height: r.spacing(16)),
          Text(
            'no_products_found'.tr(context),
            style: GoogleFonts.cairo(
              fontSize: r.fontSize(18),
              fontWeight: FontWeight.w700,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
