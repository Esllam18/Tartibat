import 'package:flutter/material.dart';
import '../widgets/products/products_app_bar.dart';
import '../widgets/products/products_tabs.dart';
import '../widgets/products/approved_products_tab.dart';
import '../widgets/products/pending_products_tab.dart';
import 'add_product_screen.dart';

class TraderProductsScreen extends StatefulWidget {
  const TraderProductsScreen({super.key});

  @override
  State<TraderProductsScreen> createState() => _TraderProductsScreenState();
}

class _TraderProductsScreenState extends State<TraderProductsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ProductsAppBar(onAdd: _navigateToAdd),
      body: Column(
        children: [
          ProductsTabs(controller: _tabController),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                ApprovedProductsTab(),
                PendingProductsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToAdd() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const AddProductScreen()));
  }
}
