import 'package:flutter/material.dart';
import 'package:tartibat/features/customer/widgets/profile/profile_menu_item_simple.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/utils/responsive.dart';

class ProfileMenuClean extends StatelessWidget {
  final VoidCallback onLanguage;
  final VoidCallback onOrders;
  final VoidCallback onFavorites;
  final VoidCallback onLogout;

  const ProfileMenuClean({
    super.key,
    required this.onLanguage,
    required this.onOrders,
    required this.onFavorites,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return ListView(
      padding: EdgeInsets.all(r.spacing(16)),
      children: [
        ProfileMenuItemClean(
          icon: Icons.language,
          title: 'language'.tr(context),
          onTap: onLanguage,
        ),
        ProfileMenuItemClean(
          icon: Icons.shopping_bag_outlined,
          title: 'my_orders'.tr(context),
          onTap: onOrders,
        ),
        ProfileMenuItemClean(
          icon: Icons.favorite_outline,
          title: 'favorites'.tr(context),
          onTap: onFavorites,
        ),
        SizedBox(height: r.spacing(32)),
        SizedBox(
          width: double.infinity,
          height: r.responsive(mobile: 50, tablet: 56, desktop: 60),
          child: ElevatedButton(
            onPressed: onLogout,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'logout'.tr(context),
              style: TextStyle(
                color: Colors.white,
                fontSize: r.fontSize(16),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
