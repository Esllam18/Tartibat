import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/localization/app_localizations.dart';
import '../data/mock_data/products_data.dart';
import '../data/models/product_model.dart';
import '../widgets/home/search_result_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  List<Product> _searchResults = [];
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    setState(() => _isSearching = true);

    final results = mockProducts.where((product) {
      final nameLower = product.name.toLowerCase();
      final nameArLower = product.nameAr.toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower) || nameArLower.contains(queryLower);
    }).toList();

    setState(() {
      _searchResults = results;
      _isSearching = false;
    });
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
        title: TextField(
          controller: _searchController,
          autofocus: true,
          onChanged: _performSearch,
          style: GoogleFonts.cairo(
            fontSize: r.fontSize(16),
            color: AppColors.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: 'search_furniture'.tr(context),
            hintStyle: GoogleFonts.cairo(color: Colors.grey.shade400),
            border: InputBorder.none,
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, size: 20),
                    onPressed: () {
                      _searchController.clear();
                      _performSearch('');
                    },
                  )
                : null,
          ),
        ),
      ),
      body: _buildBody(r),
    );
  }

  Widget _buildBody(Responsive r) {
    if (_isSearching) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_searchController.text.isEmpty) {
      return _buildEmptySearch(r);
    }

    if (_searchResults.isEmpty) {
      return _buildNoResults(r);
    }

    return ListView.builder(
      padding: EdgeInsets.all(r.spacing(16)),
      physics: const BouncingScrollPhysics(),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        return SearchResultItem(product: _searchResults[index]);
      },
    );
  }

  Widget _buildEmptySearch(Responsive r) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_rounded,
            size: 80,
            color: Colors.grey.shade300,
          ),
          SizedBox(height: r.spacing(16)),
          Text(
            'start_searching'.tr(context),
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

  Widget _buildNoResults(Responsive r) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 80,
            color: Colors.grey.shade300,
          ),
          SizedBox(height: r.spacing(16)),
          Text(
            'no_results_found'.tr(context),
            style: GoogleFonts.cairo(
              fontSize: r.fontSize(18),
              fontWeight: FontWeight.w700,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: r.spacing(8)),
          Text(
            'try_different_keywords'.tr(context),
            style: GoogleFonts.cairo(
              fontSize: r.fontSize(14),
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}
