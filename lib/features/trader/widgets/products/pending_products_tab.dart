import 'package:flutter/material.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/localization/app_localizations.dart';
import 'products_search_bar.dart';
import 'view_toggle_buttons.dart';
import 'products_grid.dart';
import 'products_list.dart';

class PendingProductsTab extends StatefulWidget {
  const PendingProductsTab({super.key});

  @override
  State<PendingProductsTab> createState() => _PendingProductsTabState();
}

class _PendingProductsTabState extends State<PendingProductsTab> {
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
                  icon: Icons.pending_outlined,
                  title: 'no_pending_products'.tr(context),
                  message: 'no_pending_products_message'.tr(context),
                )
              : _isGridView
                  ? ProductsGrid(products: _products)
                  : ProductsList(products: _products),
        ),
      ],
    );
  }
}
