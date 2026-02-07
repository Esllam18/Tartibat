import 'package:flutter/material.dart';
import 'trader_products_screen.dart';
import 'trader_orders_screen.dart';
import 'trader_profile_screen.dart';

class TraderMainLayout extends StatefulWidget {
  const TraderMainLayout({super.key});

  @override
  State<TraderMainLayout> createState() => _TraderMainLayoutState();
}

class _TraderMainLayoutState extends State<TraderMainLayout> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    TraderProductsScreen(), // FIRST SCREEN
    TraderOrdersScreen(),
    TraderProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'المنتجات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'الطلبات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'الحساب',
          ),
        ],
      ),
    );
  }
}
