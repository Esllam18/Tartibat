import 'package:flutter/material.dart';
import 'package:tartibat/features/customer/widgets/profile/profile_header_simple.dart';
import 'package:tartibat/features/customer/widgets/profile/profile_menu_simple.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const ProfileHeaderClean(),
            Expanded(
              child: ProfileMenuClean(
                onLanguage: () {},
                onOrders: () {},
                onFavorites: () {},
                onLogout: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
