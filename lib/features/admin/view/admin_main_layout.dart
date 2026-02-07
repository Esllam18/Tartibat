import 'package:flutter/material.dart';
import 'package:tartibat/features/admin/widgets/navigation/admin_dashboard_screen.dart';
import 'package:tartibat/features/admin/widgets/navigation/admin_products_screen.dart';
import '../../../core/constants/app_colors.dart';
import '../widgets/navigation/admin_drawer.dart';
import 'admin_traders_screen.dart';
import 'admin_orders_screen.dart';

class AdminMainLayout extends StatefulWidget {
  const AdminMainLayout({super.key});

  @override
  State<AdminMainLayout> createState() => _AdminMainLayoutState();
}

class _AdminMainLayoutState extends State<AdminMainLayout> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    AdminDashboardScreen(),
    AdminTradersScreen(),
    AdminProductsScreen(),
    AdminOrdersScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: AdminDrawer(
        currentIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          Navigator.pop(context);
        },
      ),
      body: _screens[_currentIndex],
    );
  }
}
