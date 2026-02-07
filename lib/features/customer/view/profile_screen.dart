import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/localization/app_localizations.dart';
import '../widgets/profile/profile_header.dart';
import '../widgets/profile/profile_menu_section.dart';
import '../widgets/profile/profile_stats_section.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(child: ProfileHeader()),
          SliverToBoxAdapter(child: SizedBox(height: r.spacing(10))),
          const SliverToBoxAdapter(child: ProfileStatsSection()),
          SliverToBoxAdapter(child: SizedBox(height: r.spacing(20))),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: r.paddingHorizontal),
              child: Column(
                children: [
                  ProfileMenuSection(
                    title: 'account'.tr(context),
                    items: const [
                      {
                        'icon': Icons.person_outline,
                        'titleKey': 'edit_profile',
                        'action': 'edit_profile'
                      },
                      {
                        'icon': Icons.shopping_bag_outlined,
                        'titleKey': 'my_orders',
                        'action': 'my_orders'
                      },
                      {
                        'icon': Icons.location_on_outlined,
                        'titleKey': 'addresses',
                        'action': 'addresses'
                      },
                    ],
                  ),
                  SizedBox(height: r.spacing(20)),
                  ProfileMenuSection(
                    title: 'settings'.tr(context),
                    items: const [
                      {
                        'icon': Icons.language,
                        'titleKey': 'language',
                        'action': 'language'
                      },
                      {
                        'icon': Icons.notifications_outlined,
                        'titleKey': 'notifications',
                        'action': 'notifications'
                      },
                      {
                        'icon': Icons.security,
                        'titleKey': 'privacy',
                        'action': 'privacy'
                      },
                    ],
                  ),
                  SizedBox(height: r.spacing(20)),
                  ProfileMenuSection(
                    title: 'support'.tr(context),
                    items: const [
                      {
                        'icon': Icons.help_outline,
                        'titleKey': 'help_center',
                        'action': 'help_center'
                      },
                      {
                        'icon': Icons.info_outline,
                        'titleKey': 'about_app',
                        'action': 'about_app'
                      },
                      {
                        'icon': Icons.share_outlined,
                        'titleKey': 'share_app',
                        'action': 'share_app'
                      },
                    ],
                  ),
                  SizedBox(height: r.spacing(20)),
                  _buildLogoutButton(context, r),
                  SizedBox(height: r.spacing(40)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context, Responsive r) {
    return Container(
      width: double.infinity,
      height: r.responsive(mobile: 56, tablet: 60, desktop: 64),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.error, Color(0xFFE57373)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.error.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () => _showLogoutDialog(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout,
                color: Colors.white,
                size: r.responsive(mobile: 22, tablet: 24, desktop: 26)),
            SizedBox(width: r.spacing(12)),
            Text(
              'logout'.tr(context),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            const Icon(Icons.logout, color: AppColors.error, size: 28),
            const SizedBox(width: 12),
            Text('logout'.tr(context)),
          ],
        ),
        content: Text('logout_confirmation'.tr(context)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('cancel'.tr(context),
                style: const TextStyle(color: AppColors.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Implement logout logic here
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('logout_success'.tr(context)),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: Text('confirm'.tr(context)),
          ),
        ],
      ),
    );
  }
}
