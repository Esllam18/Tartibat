import 'package:flutter/material.dart';
import '../../../core/widgets/loading_state.dart';
import '../widgets/dashboard/dashboard_stats_grid.dart';
import '../widgets/dashboard/quick_actions.dart';
import '../widgets/dashboard/recent_orders_section.dart';
import '../widgets/dashboard/sales_chart.dart';
import 'add_product_screen.dart';

class TraderDashboardScreen extends StatefulWidget {
  const TraderDashboardScreen({super.key});

  @override
  State<TraderDashboardScreen> createState() => _TraderDashboardScreenState();
}

class _TraderDashboardScreenState extends State<TraderDashboardScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const LoadingState();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const DashboardStatsGrid(
            totalRevenue: 2450000,
            totalOrders: 156,
            totalProducts: 48,
            totalCustomers: 89,
          ),
          const SizedBox(height: 24),
          QuickActions(
            onAddProduct: _navigateToAddProduct,
            onViewOrders: () {},
            onViewProducts: () {},
          ),
          const SizedBox(height: 24),
          const SalesChart(),
          const SizedBox(height: 24),
          RecentOrdersSection(orders: _getMockOrders()),
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

  List<Map<String, dynamic>> _getMockOrders() {
    return [
      {'id': '1234', 'date': '2026-02-06', 'total': 125000},
      {'id': '1235', 'date': '2026-02-06', 'total': 85000},
      {'id': '1236', 'date': '2026-02-05', 'total': 210000},
    ];
  }
}
