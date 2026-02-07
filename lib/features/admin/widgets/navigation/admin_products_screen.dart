import 'package:flutter/material.dart';
import 'package:tartibat/core/constants/app_colors.dart';
import 'package:tartibat/core/localization/app_localizations.dart';
import 'package:tartibat/core/widgets/loading_state.dart';
import 'package:tartibat/features/admin/widgets/common/admin_app_bar.dart';
import 'package:tartibat/features/admin/widgets/products/admin_products_list.dart';
import 'package:tartibat/features/admin/widgets/products/products_filter_tabs.dart';

class AdminProductsScreen extends StatefulWidget {
  const AdminProductsScreen({super.key});

  @override
  State<AdminProductsScreen> createState() => _AdminProductsScreenState();
}

class _AdminProductsScreenState extends State<AdminProductsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AdminAppBar(title: 'products'.tr(context)),
      body: Column(
        children: [
          ProductsFilterTabs(controller: _tabController),
          Expanded(
            child: _isLoading
                ? const LoadingState()
                : TabBarView(
                    controller: _tabController,
                    children: const [
                      AdminProductsList(status: 'pending'),
                      AdminProductsList(status: 'approved'),
                      AdminProductsList(status: 'rejected'),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
