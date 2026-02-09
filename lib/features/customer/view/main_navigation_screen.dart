import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tartibat/features/customer/data/bloc/cart_cubit.dart';
import 'package:tartibat/features/customer/data/bloc/cart_state.dart';
import 'package:tartibat/features/customer/data/bloc/favorites_cubit.dart';
import 'package:tartibat/features/customer/data/bloc/favorites_state.dart';
import 'package:tartibat/features/customer/view/customer_home_screen.dart';
import 'package:tartibat/features/customer/widgets/custom_bottom_nav_item.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/localization/app_localizations.dart';

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
    HomeScreen(),
    FavoritesScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: r.spacing(8),
              vertical: r.spacing(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomBottomNavItem(
                  icon: Icons.home_outlined,
                  activeIcon: Icons.home_rounded,
                  label: 'home'.tr(context),
                  isActive: _currentIndex == 0,
                  onTap: () => setState(() => _currentIndex = 0),
                ),
                BlocBuilder<FavoritesCubit, FavoritesState>(
                  builder: (context, state) {
                    final count = state is FavoritesLoaded ? state.count : 0;
                    return CustomBottomNavItem(
                      icon: Icons.favorite_border,
                      activeIcon: Icons.favorite,
                      label: 'favorites'.tr(context),
                      isActive: _currentIndex == 1,
                      badgeCount: count,
                      onTap: () => setState(() => _currentIndex = 1),
                    );
                  },
                ),
                BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    final count = state is CartLoaded
                        ? state.itemCount
                        : 0; // ✅ Use itemCount
                    return CustomBottomNavItem(
                      icon: Icons.shopping_cart_outlined,
                      activeIcon: Icons.shopping_cart,
                      label: 'cart'.tr(context),
                      isActive: _currentIndex == 2,
                      badgeCount: count,
                      onTap: () => setState(() => _currentIndex = 2),
                    );
                  },
                ),
                CustomBottomNavItem(
                  icon: Icons.person_outline,
                  activeIcon: Icons.person,
                  label: 'profile'.tr(context),
                  isActive: _currentIndex == 3,
                  onTap: () => setState(() => _currentIndex = 3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
