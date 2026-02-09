import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/localization/app_localizations.dart';
import 'merchant_dashboard_screen.dart';
import 'merchant_products_screen.dart';
import 'merchant_orders_screen.dart';
import 'merchant_profile_screen.dart';

class MerchantMainLayout extends StatefulWidget {
  const MerchantMainLayout({super.key});

  @override
  State<MerchantMainLayout> createState() => _MerchantMainLayoutState();
}

class _MerchantMainLayoutState extends State<MerchantMainLayout> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    MerchantDashboardScreen(),
    MerchantProductsScreen(),
    MerchantOrdersScreen(),
    MerchantProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: r.spacing(16),
              vertical: r.spacing(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, Icons.dashboard_outlined, Icons.dashboard,
                    'dashboard'.tr(context)),
                _buildNavItem(1, Icons.inventory_2_outlined, Icons.inventory_2,
                    'products'.tr(context)),
                _buildNavItem(2, Icons.receipt_long_outlined,
                    Icons.receipt_long, 'orders'.tr(context)),
                _buildNavItem(3, Icons.person_outline, Icons.person,
                    'profile'.tr(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
      int index, IconData icon, IconData activeIcon, String label) {
    final r = context.responsive;
    final isActive = _currentIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: r.spacing(16),
          vertical: r.spacing(8),
        ),
        decoration: BoxDecoration(
          gradient: isActive ? AppColors.primaryGradient : null,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              color: isActive ? Colors.white : Colors.grey.shade600,
              size: 24,
            ),
            SizedBox(height: r.spacing(4)),
            Text(
              label,
              style: GoogleFonts.cairo(
                fontSize: r.fontSize(11),
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
                color: isActive ? Colors.white : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
