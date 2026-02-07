import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../localization/app_localizations.dart';

class ProductSearchDelegate extends SearchDelegate<Map<String, dynamic>?> {
  final List<Map<String, dynamic>> products;

  ProductSearchDelegate(this.products);

  @override
  String get searchFieldLabel => 'search_products';

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surface,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
        hintStyle: TextStyle(color: AppColors.textSecondary),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = '',
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = _getFilteredProducts();
    return _buildResultsList(context, results);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = _getFilteredProducts();
    return _buildResultsList(context, suggestions);
  }

  List<Map<String, dynamic>> _getFilteredProducts() {
    return products.where((product) {
      final name = (product['name'] ?? '').toString().toLowerCase();
      return name.contains(query.toLowerCase());
    }).toList();
  }

  Widget _buildResultsList(
      BuildContext context, List<Map<String, dynamic>> results) {
    if (results.isEmpty) {
      return Center(
        child: Text('no_results'.tr(context),
            style: AppTextStyles.bodyMedium(context)),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final product = results[index];
        return ListTile(
          leading: const Icon(Icons.search),
          title: Text(product['name'] ?? ''),
          subtitle: Text('${product['price']} IQD'),
          onTap: () => close(context, product),
        );
      },
    );
  }
}
