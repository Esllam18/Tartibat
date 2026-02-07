import 'package:flutter/material.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/localization/app_localizations.dart';
import 'products_search_bar.dart';
import 'view_toggle_buttons.dart';
import 'products_grid.dart';
import 'products_list.dart';

class ApprovedProductsTab extends StatefulWidget {
  const ApprovedProductsTab({super.key});

  @override
  State<ApprovedProductsTab> createState() => _ApprovedProductsTabState();
}

class _ApprovedProductsTabState extends State<ApprovedProductsTab> {
  bool _isGridView = true;
  final List<Map<String, dynamic>> _products = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProductsSearchBar(onSearch: (query) {}),
        ViewToggleButtons(
          isGridView: _isGridView,
          onToggle: () => setState(() => _isGridView = !_isGridView),
        ),
        Expanded(
          child: _products.isEmpty
              ? EmptyState(
                  icon: Icons.inventory_outlined,
                  title: 'no_approved_products'.tr(context),
                  message: 'no_approved_products_message'.tr(context),
                )
              : _isGridView
                  ? ProductsGrid(products: _products)
                  : ProductsList(products: _products),
        ),
      ],
    );
  }
}
