import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/localization/app_localizations.dart';
import 'trader_menu_item.dart';

class TraderProfileMenu extends StatelessWidget {
  const TraderProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildSection(
            context,
            title: 'account_settings'.tr(context),
            items: [
              TraderMenuItem(
                icon: Icons.person,
                title: 'edit_profile'.tr(context),
                onTap: () {},
              ),
              TraderMenuItem(
                icon: Icons.lock,
                title: 'change_password'.tr(context),
                onTap: () {},
              ),
              TraderMenuItem(
                icon: Icons.notifications,
                title: 'notifications'.tr(context),
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildLogoutButton(context),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required List<Widget> items,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(title, style: AppTextStyles.h4(context)),
          ),
          const Divider(height: 1),
          ...items,
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.error,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        'logout'.tr(context),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
