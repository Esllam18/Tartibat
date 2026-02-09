import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tartibat/features/customer/data/bloc/favorites_cubit.dart';
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
    List<Product> filtered = widget.category == 'all'
        ? List.from(mockProducts)
        : mockProducts.where((p) => p.category == widget.category).toList();

    filtered = filtered
        .where((p) => p.price >= priceRange.start && p.price <= priceRange.end)
        .toList();

    final sortBy = _filters!['sortBy'] as String;
    if (sortBy == 'price_low') {
      filtered.sort((a, b) => a.price.compareTo(b.price));
    } else if (sortBy == 'price_high') {
      filtered.sort((a, b) => b.price.compareTo(a.price));
    }

    setState(() {
      _products = filtered;
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

    return BlocProvider.value(
      value: context.read<FavoritesCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: _buildAppBar(context, r),
        body: _products.isEmpty ? _buildEmptyState(r) : _buildList(r),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, Responsive r) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      shadowColor: Colors.black.withOpacity(0.1),
      leading: IconButton(
        icon: Container(
          padding: EdgeInsets.all(r.spacing(8)),
          decoration: BoxDecoration(
            color: AppColors.background,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back,
              color: AppColors.textPrimary, size: 20),
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        widget.title ?? 'all_products'.tr(context),
        style: GoogleFonts.cairo(
          fontSize: r.fontSize(20),
          fontWeight: FontWeight.w900,
          color: AppColors.textPrimary,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Container(
            padding: EdgeInsets.all(r.spacing(8)),
            decoration: BoxDecoration(
              color: AppColors.background,
              shape: BoxShape.circle,
            ),
            child: Icon(
              _isGridView ? Icons.view_list_rounded : Icons.grid_view_rounded,
              color: AppColors.textPrimary,
              size: 20,
            ),
          ),
          onPressed: () => setState(() => _isGridView = !_isGridView),
        ),
        IconButton(
          icon: Container(
            padding: EdgeInsets.all(r.spacing(8)),
            decoration: BoxDecoration(
              color: AppColors.background,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.tune_rounded,
                color: AppColors.textPrimary, size: 20),
          ),
          onPressed: _showFilters,
        ),
        SizedBox(width: r.spacing(8)),
      ],
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
        itemBuilder: (context, index) => ProductCardGrid(
          product: _products[index],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(r.spacing(16)),
      physics: const BouncingScrollPhysics(),
      itemCount: _products.length,
      itemBuilder: (context, index) => ProductCardList(
        product: _products[index],
      ),
    );
  }

  Widget _buildEmptyState(Responsive r) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(r.spacing(30)),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.inventory_2_outlined,
              size: r.responsive(mobile: 80, tablet: 100, desktop: 120),
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: r.spacing(24)),
          Text(
            'no_products_found'.tr(context),
            style: GoogleFonts.cairo(
              fontSize: r.fontSize(22),
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: r.spacing(12)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: r.spacing(40)),
            child: Text(
              'try_different_filters'.tr(context),
              style: GoogleFonts.cairo(
                fontSize: r.fontSize(15),
                color: AppColors.textSecondary,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: r.spacing(24)),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                _filters = null;
                _loadProducts();
              });
            },
            icon: const Icon(Icons.refresh_rounded, size: 20),
            label: Text(
              'reset_filters'.tr(context),
              style: GoogleFonts.cairo(
                fontSize: r.fontSize(16),
                fontWeight: FontWeight.w700,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: r.spacing(24),
                vertical: r.spacing(14),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }
}
