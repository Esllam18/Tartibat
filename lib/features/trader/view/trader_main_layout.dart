import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../widgets/trader_bottom_nav.dart';
import 'trader_dashboard_screen.dart';
import 'trader_orders_screen.dart';
import 'trader_products_screen.dart';
import 'trader_profile_screen.dart';

class TraderMainLayout extends StatefulWidget {
  const TraderMainLayout({super.key});

  @override
  State<TraderMainLayout> createState() => _TraderMainLayoutState();
}

class _TraderMainLayoutState extends State<TraderMainLayout> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    TraderDashboardScreen(),
    TraderOrdersScreen(),
    TraderProductsScreen(),
    TraderProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: _screens[_currentIndex],
      bottomNavigationBar: TraderBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
