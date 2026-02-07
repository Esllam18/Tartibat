import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/localization/app_localizations.dart';
import 'customer_home_screen.dart';
import 'favorites_screen.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';

class CustomerMainLayout extends StatefulWidget {
  const CustomerMainLayout({super.key});

  @override
  State<CustomerMainLayout> createState() => _CustomerMainLayoutState();
}

class _CustomerMainLayoutState extends State<CustomerMainLayout> {
  int _currentIndex = 0;

  static const List<Widget> _screens = [
    CustomerHomeScreen(),
    FavoritesScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowMedium,
              blurRadius: 20,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.surface,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textSecondary,
          elevation: 0,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(fontSize: 11),
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined, size: 26),
              activeIcon: _buildActiveIcon(Icons.home_rounded, 24),
              label: 'home'.tr(context),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.favorite_border, size: 24),
              activeIcon: _buildActiveIcon(Icons.favorite, 22),
              label: 'favorites'.tr(context),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.shopping_cart_outlined, size: 24),
              activeIcon: _buildActiveIcon(Icons.shopping_cart, 22),
              label: 'cart'.tr(context),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person_outline, size: 24),
              activeIcon: _buildActiveIcon(Icons.person, 22),
              label: 'profile'.tr(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveIcon(IconData icon, double size) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      ),
      child: Icon(icon, color: AppColors.textWhite, size: size),
    );
  }
}
