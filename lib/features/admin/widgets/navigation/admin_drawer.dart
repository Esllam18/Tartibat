import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/localization/app_localizations.dart';
import 'admin_drawer_item.dart';

class AdminDrawer extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemSelected;

  const AdminDrawer({
    super.key,
    required this.currentIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                AdminDrawerItem(
                  icon: Icons.dashboard,
                  title: 'dashboard'.tr(context),
                  isSelected: currentIndex == 0,
                  onTap: () => onItemSelected(0),
                ),
                AdminDrawerItem(
                  icon: Icons.store,
                  title: 'traders'.tr(context),
                  isSelected: currentIndex == 1,
                  onTap: () => onItemSelected(1),
                ),
                AdminDrawerItem(
                  icon: Icons.inventory,
                  title: 'products'.tr(context),
                  isSelected: currentIndex == 2,
                  onTap: () => onItemSelected(2),
                ),
                AdminDrawerItem(
                  icon: Icons.shopping_bag,
                  title: 'orders'.tr(context),
                  isSelected: currentIndex == 3,
                  onTap: () => onItemSelected(3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(color: AppColors.primary),
      child: SafeArea(
        child: Row(
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: Icon(Icons.admin_panel_settings,
                  size: 30, color: AppColors.primary),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Admin Panel',
                  style:
                      AppTextStyles.h3(context).copyWith(color: Colors.white),
                ),
                Text(
                  'admin@tartibat.com',
                  style: AppTextStyles.bodySmall(context)
                      .copyWith(color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
