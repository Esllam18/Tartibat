import 'package:flutter/material.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/localization/app_localizations.dart';
import 'admin_product_card.dart';

class AdminProductsList extends StatelessWidget {
  final String status;

  const AdminProductsList({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    // Mock data - replace with real data
    final products = <Map<String, dynamic>>[];

    if (products.isEmpty) {
      return EmptyState(
        icon: Icons.inventory_outlined,
        title: 'no_products'.tr(context),
        message: 'no_products_message'.tr(context),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return AdminProductCard(product: products[index], status: status);
      },
    );
  }
}
